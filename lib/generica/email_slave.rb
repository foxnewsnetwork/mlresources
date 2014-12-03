module Generica; end
class Generica::EmailSlave
  def dispatch_emails!
    return puts "no emails" if _emails.blank?
    _requests.update_all(status: :attempt_dispatch) 
    _postal_pipeline.call _emails
    _requests.update_all(status: :delivered)
  end
  private
  def _postal_pipeline
    _group_by_user_emails >> _crunch_into_digest >> _send_off!
  end
  def _group_by_user_emails
    -> (emails) { Sorter.group_by_user_emails emails }
  end
  def _crunch_into_digest
    -> (email_hash) { _hash_map_crunch email_hash }
  end
  def _send_off!
    -> (email_hash) { _hash_map_dispatch email_hash }
  end
  def _requests
    @requests ||= _request_process.call Apiv1::EmailRequest
  end
  def _request_process
    _consider_workload >> _consider_email_address
  end
  def _consider_email_address
    -> (scope) { @user.present? ? scope.meant_for_email(@email) : scope }
  end
  def _consider_workload
    -> (klass) { klass.belonging_to_the_user_with_oldest_undelivered }
  end
  def _emails
    @emails ||= _requests.map(&:mailify)
  end
  def _hash_map_dispatch(hash)
    _right_map(hash) { |email| Dispatcher.dispatch email }
  end
  def _hash_map_crunch(hash)
    _right_map(hash) { |emails| Cruncher.crunch emails }
  end
  def _right_map(hash, &block)
    thing = hash.map { |key_and_value| [key_and_value.first, yield(key_and_value.last)] }
    Hash[thing]
  end
end

class Generica::EmailSlave::Sorter
  class << self
    def group_by_user_emails(emails)
      emails.reduce({}) do |hash, email|
        hash[email.to.first] ||= []
        hash[email.to.first].push email
        hash
      end
    end
  end
end

class Generica::EmailSlave::Cruncher
  class << self
    def crunch(emails)
      return emails.first if emails.count < 2
      Apiv1::AggregateMailer.summary emails
    end
  end
end

class Generica::EmailSlave::Dispatcher
  class << self
    def dispatch(email)
      gmail.compose(email).deliver!
    end
    def gmail(&block)
      Gmail.connect(username, password)
    end
    def username
      _account_hash["username"]
    end
    def password
      _account_hash["password"]
    end
    private
    def _account_hash
      @account_hash ||= YAML.load(_template.render)[Rails.env]
    end
    def _template
      Tilt::ERBTemplate.new Rails.root.join("config", "email.yml").to_s
    end
  end
end