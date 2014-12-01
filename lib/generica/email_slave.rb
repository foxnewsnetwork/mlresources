module Generica; end
class Generica::EmailSlave
  class << self
    def dispatch_emails!

    end
  end
  def dispatch_emails!
    _postal_pipeline.call _emails
  end
  private
  def _postal_pipeline
    _group_by_user_emails >> _crunch_into_digest >> _send_off!
  end
  def _group_by_user_emails
    -> (emails) { Sorter.group_by_user_emails emails }
  end
  def _crunch_into_digest
    -> (email_hash) { _hash_map email_hash { |emails| Cruncher.crunch emails } }
  end
  def _send_off!
    -> (email_hash) { _hash_map email_hash { |email| Dispatcher.dispatch email } }
  end
  def _emails
    
  end
  def _hash_map(hash, &block)
    thing = hash.map { |key_and_value| [key_and_value.first, yield(key_and_value.last)] }
    Hash[thing]
  end
end

class Generica::EmailSlave::Sorter
  class << self
    def group_by_user_emails(emails)
      emails.reduce({}) do |hash, email|
        hash[email.to] ||= []
        hash[email.to].push email
        hash
      end
    end
  end
end

class Generica::EmailSlave::Cruncher
  class << self
    def crunch(emails)
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