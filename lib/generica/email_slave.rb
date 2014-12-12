module Generica; end
class Generica::EmailSlave
  def dispatch_emails!
    _dispatch_process.call
  end
  private
  def _dispatch_process
    _all_unfulfilled_requests >> _group_by_target_email >= _crunch_down_emails >= (_dispatch_email! % _manage_failure!)
  end
  def _all_unfulfilled_requests
    Arrows.lift Apiv1::EmailRequest.awaiting_delivery
  end
  def _group_by_target_email
    Arrows.lift -> (requests) { Sorter.group_by_to requests }  
  end
  def _crunch_down_emails
    Arrows.lift -> (requests) { Cruncher.crunch requests }
  end
  def _dispatch_email!
    Arrows.lift -> (mail) { Dispatcher.dispatch! mail }
  end
  def _manage_failure!
    Arrows.lift -> (requests) { GarbageMan.cleanup! requests }
  end
end

class Generica::EmailSlave::Sorter
  class << self
    def group_by_to(requests)
      requests.group_by { |request| request.to }.map(&:last)
    end
  end
end

class Generica::EmailSlave::GarbageMan
  class << self
    def cleanup!(requests)
      return if requests.blank?
      requests.map(&:mark_as_failed!)
    end
  end
end

class Generica::EmailSlave::Cruncher
  class << self
    def crunch(requests)
      mails_or_fails = requests.map { |request| _convert_request request }
      _crunch_process.call mails_or_fails
    end
    private
    def _crunch_process
      _separate_good_and_evil >> (_payload % _payload) >> (_crunch_good_emails % Arrows::ID)
    end
    def _crunch_good_emails
      Arrows.lift -> (emails) { emails.count < 2 ? emails.first : Apiv1::AggregateMailer.summary(emails) }
    end
    def _payload
      Arrows.lift -> (eithers) { eithers.map &:payload }
    end
    def _separate_good_and_evil
      Arrows.lift -> (mails_and_fails) { [mails_and_fails.select(&:good?), mails_and_fails.reject(&:good?)] }
    end
    def _convert_request(request)
      begin
        mail = request.mailify
        request.mark_as_delivered!
        Arrows.good mail
      rescue
        Arrows.evil request
      end
    end
  end
end

class Generica::EmailSlave::Dispatcher
  class << self
    def dispatch!(email)
      return if email.blank?
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