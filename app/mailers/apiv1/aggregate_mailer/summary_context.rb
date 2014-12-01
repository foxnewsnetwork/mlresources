class Apiv1::AggregateMailer::SummaryContext
  class NoEmailsToAggregate < StandardError; end
  delegate :to,
    :from,
    :cc,
    :bcc,
    to: :_first_email
  def initialize(emails)
    @emails = emails
    raise NoEmailsToAggregate, "no emails to aggregate" if @emails.blank?
  end
  def subject
    [_preamble, _email_type_and_counts.join(", ")].join(" ").strip
  end
  def html_bodies
    @emails.map do |email|
      CoreHtmlFinder.html_body_gist email
    end
  end
  def plain_bodies
    @emails.map do |email|
      CorePlainFinder.plain_body_gist email
    end
  end
  def whoever_this_is_sent_to
    FormalTitleFinder.formal_title _first_email
  end
  private
  def _preamble
    "Update:"
  end
  def _email_type_and_counts
    _email_groups.map do |type_name, emails|
      _that_pluralize_thing noun: type_name, count: emails.count
    end
  end
  def _that_pluralize_thing(noun: noun, count: count)
    if count > 1 || count == 0
      "#{count} #{noun.pluralize}"
    else
      "#{count} #{noun.singularize}"
    end
  end
  def _first_email
    @emails.first
  end
  def _email_groups
    @emails.reduce({}) do |hash, email|
      s = _simplify_subject email.subject
      hash[s] ||= []
      hash[s].push email
      hash
    end
  end
  def _simplify_subject(subject)
    subject.split("-").first.to_s.strip
  end
end

class Apiv1::AggregateMailer::SummaryContext::CoreHtmlFinder
  class << self
    def html_body_gist(mail)
      _process.call mail
    end
    private
    def _process
      _get_html_part >> _parse_by_nokogiri >> _find_via_css >> _return_html
    end
    def _get_html_part
      -> (mail) { mail.html_part.to_s }
    end
    def _parse_by_nokogiri
      -> (string) { Nokogiri::HTML(string) }
    end
    def _find_via_css
      -> (nokodoc) { nokodoc.css "table.the-gist" }
    end
    def _return_html
      -> (nokoel) { nokoel.map(&:to_s).join("\n") }
    end
  end
end

class Apiv1::AggregateMailer::SummaryContext::FormalTitleFinder
  class << self
    def formal_title(mail)
      _process.call mail
    end
    private
    def _process
      _get_html_part >> _parse_by_nokogiri >> _find_via_css >> _return_html
    end
    def _get_html_part
      -> (mail) { mail.html_part.to_s }
    end
    def _parse_by_nokogiri
      -> (string) { Nokogiri::HTML(string) }
    end
    def _find_via_css
      -> (nokodoc) { nokodoc.css "span.product-owner" }
    end
    def _return_html
      -> (nokoel) { nokoel.first.text }
    end
  end
end

class Apiv1::AggregateMailer::SummaryContext::CorePlainFinder
  class << self
    def plain_body_gist(mail)
      _process.call mail
    end
    private
    def _process
      _get_plain_part
    end
    def _get_plain_part
      -> (mail) { mail.text_part.to_s }
    end
  end
end