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

class Apiv1::Picture < ActiveRecord::Base
  belongs_to :depictable,
    polymorphic: true

  has_attached_file :pic,
    styles: { thumb: "100x100>" },
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
    url: "/system/attachments/:id/pic_:style.:extension",
    default_url: "/emoji/458.png"
  
  validates_attachment_content_type :pic, 
    content_type: /\Aimage\/.*\Z/

  validates :pic,
    :depictable_type,
    presence: true

  def to_ember_hash
    attributes.merge pic_url: pic.url,
      thumb_url: pic.url(:thumb)
  end
end
