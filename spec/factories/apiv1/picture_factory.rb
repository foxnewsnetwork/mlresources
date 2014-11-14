# == Schema Information
#
# Table name: apiv1_pictures
#
#  id               :integer          not null, primary key
#  depictable_id    :integer
#  depictable_type  :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  pic_file_name    :string(255)
#  pic_content_type :string(255)
#  pic_file_size    :integer
#  pic_updated_at   :datetime
#

class Apiv1::PictureFactory < Apiv1::BaseFactory
  def self.rack_file
    Rack::Test::UploadedFile.new(Rails.root.join("public", "tests", "dog.png"), "image/png")
  end
  def attributes
    {
      pic: self.class.rack_file
    }
  end
end
