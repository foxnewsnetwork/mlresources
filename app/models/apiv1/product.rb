# == Schema Information
#
# Table name: apiv1_products
#
#  id             :integer          not null, primary key
#  permalink      :string(255)
#  sku            :string(255)
#  material       :string(255)
#  quality        :string(255)
#  price          :string(255)
#  amount         :string(255)
#  place          :string(255)
#  others         :text
#  created_at     :datetime
#  updated_at     :datetime
#  showcase_order :integer
#

class Apiv1::Product < ActiveRecord::Base
  include ::Elasticsearch::Model
  include ::Elasticsearch::Model::Callbacks
  Fields = [
    :sku,
    :material,
    :price,
    :amount,
    :place,
    :others,
    :quality,
    :showcase_order
  ]
  has_many :taxon_relationships,
    class_name: 'Apiv1::Listings::TaxonRelationship',
    as: :listing
  has_many :taxons,
    through: :taxon_relationships,
    class_name: 'Apiv1::Taxon'
  has_many :pictures,
    class_name: 'Apiv1::Picture',
    as: :depictable,
    dependent: :destroy
  has_many :attachments,
    class_name: 'Apiv1::Attachment',
    as: :attachable,
    dependent: :destroy

  scope :belonging_to_taxon,
    -> (taxon) { joins(:taxons).where("#{Apiv1::Taxon.table_name}.id = ?", taxon.id) }

  scope :involving_taxon_ids,
    -> (taxon_ids) { joins(:taxons).where("#{Apiv1::Taxon.table_name}.id" => taxon_ids) }

  scope :involving_taxons,
    -> (taxons) { involving_taxon_ids taxons.map(&:id) }

  scope :order_by_created_at,
    -> { order "#{self.table_name}.created_at desc"}

  scope :worthy_of_showcase,
    -> { where "#{self.table_name}.showcase_order is not null" }

  scope :order_by_showcase,
    -> { order "#{self.table_name}.showcase_order asc"}

  validates :material,
    :pictures,
    presence: true

  before_create :_make_permalink,
    :_make_showcase_order

  class << self
    def find_by_permalink_or_id!(permalink_or_id)
      find_by_permalink(permalink_or_id) || find(permalink_or_id)
    end
  end

  def to_ember_hash
    attributes.merge pictures: pictures.map(&:id),
      taxons: taxons.map(&:id),
      attachments: attachments.map(&:id)
  end

  private
  def _make_permalink
    self.permalink ||= Apiv1::Permalinkifier.permalinkify material
  end
  def _make_showcase_order
    self.showcase_order ||= self.class.last.try(:id).to_i + 1
  end
end
