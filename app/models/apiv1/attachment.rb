# == Schema Information
#
# Table name: apiv1_attachments
#
#  id                    :integer          not null, primary key
#  attachable_id         :integer
#  attachable_type       :string(255)
#  document_file_name    :string(255)
#  document_content_type :string(255)
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime
#  updated_at            :datetime
#

class Apiv1::Attachment < ActiveRecord::Base
  DocumentTypes = [
    "application/pdf",
    "application/docx",
    "application/doc",
    "application/xls",
    "application/xlsx",
    "application/octet-stream",
    "text/plain",
    "image/jpeg",
    "image/gif",
    "image/png"
  ]
  belongs_to :attachable,
    polymorphic: true

  has_attached_file :document,
    content_type: { content_type: DocumentTypes },
    url: "/system/documents/:id/pic_:style.:extension",
    default_url: "/emoji/458.png"

  validates_attachment_content_type :document, 
    content_type: /\A(image|text|application)\/.*\Z/
  
  def to_ember_hash
    attributes.merge fileName: document_file_name,
      fileType: document_content_type,
      fileUrl: document.url
  end
end
