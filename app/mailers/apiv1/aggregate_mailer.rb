class Apiv1::AggregateMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "apiv1/layouts/email"
  def summary(emails)
    @ctx = Apiv1::AggregateMailer::SummaryContext.new emails

    mail to: @ctx.to,
      from: @ctx.from,
      cc: @ctx.cc,
      bcc: @ctx.bcc,
      subject: @ctx.subject
  end
end
