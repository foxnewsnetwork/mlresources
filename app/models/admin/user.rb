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
#

class Admin::User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :email,
    presence: true
  def to_ember_hash
    {
      id: id,
      email: email
    }
  end
end
