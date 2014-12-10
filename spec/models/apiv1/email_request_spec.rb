# == Schema Information
#
# Table name: apiv1_email_requests
#
#  id           :integer          not null, primary key
#  to           :string(255)      not null
#  cc           :string(255)
#  bcc          :string(255)
#  subject      :string(255)
#  status       :string(255)
#  from         :string(255)
#  mailer_class :string(255)      not null
#  deleted_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Apiv1::EmailRequest do
end
