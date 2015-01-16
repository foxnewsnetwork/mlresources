# == Schema Information
#
# Table name: admin_users
#
#  id                           :integer          not null, primary key
#  email                        :string(255)      not null
#  crypted_password             :string(255)      not null
#  salt                         :string(255)      not null
#  created_at                   :datetime
#  updated_at                   :datetime
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  user_rank                    :string(255)
#  company_name                 :string(255)
#  phone_number                 :string(255)
#  about_me                     :text(65535)
#  address                      :string(255)
#

class Admin::UserFactory < Apiv1::BaseFactory
  class << self
    def mock
      Admin::User.new(attributes).tap(&:save!)
    end
    def attributes
      {
        email: Faker::Internet.email,
        password: "asdf123",
        password_confirmation: "asdf123",
        company_name: Faker::Company.name,
        phone_number: '554654',
        address: Faker::AddressUS.street_address,
        user_rank: 'admin'
      }
    end
  end
  def attributes
    self.class.attributes
  end
end
