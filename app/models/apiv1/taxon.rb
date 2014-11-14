# == Schema Information
#
# Table name: apiv1_taxons
#
#  id             :integer          not null, primary key
#  parent_id      :integer
#  root_genus     :string(255)      not null
#  taxon_name     :string(255)      not null
#  explanation    :string(255)
#  permalink      :string(255)      not null
#  first_child_at :datetime
#  created_at     :datetime
#  updated_at     :datetime
#

class Apiv1::Taxon < ActiveRecord::Base
  Fields = [:taxon_name, :explanation, :parent_id]
  class << self
    def find_by_permalink_genus(str, genus)
      permalink = Apiv1::Permalinkifier.permalinkify str
      by_root_genus(genus).by_permalink(permalink).first
    end
    def find_by_permalink_genus!(str, genus)
      taxon = find_by_permalink_genus str, genus
      raise ActiveRecord::RecordNotFound, "no permalink with #{str} under genus #{genus}" if taxon.blank?
      taxon
    end
    def pipeline(*lambdas)
      lambdas.reduce self do |pipes, pipe|
        pipe.call(pipes) || pipes
      end
    end
  end
  has_many :taxon_relationships,
    class_name: 'Apiv1::Listings::TaxonRelationship'

  belongs_to :parent,
    class_name: 'Apiv1::Taxon'

  has_many :children,
    class_name: 'Apiv1::Taxon',
    foreign_key: 'parent_id'

  before_validation :_create_permalink,
    :_create_root_genus
  before_create :_inform_parent

  validates :root_genus,
    :taxon_name,
    :permalink,
    presence: true

  scope :children_of_parent,
    -> (p_id) { where "#{self.table_name}.parent_id = ?", p_id } 

  scope :by_permalink,
    -> (p) { where "#{self.table_name}.permalink = ?", p }

  scope :by_root_genus,
    -> (asdf) { where "#{self.table_name}.root_genus = ?", asdf }

  scope :leaves_of_root,
    -> (genus) { by_root_genus(genus).not_parent }

  scope :not_parent,
    -> { where "#{self.table_name}.first_child_at is null" }

  scope :root_generation,
    -> { where "#{self.table_name}.parent_id is null" }
    
  def have_first_child!
    update(first_child_at: DateTime.now) if first_child_at.blank?
  end

  def listings
    Apiv1::Product.belonging_to_taxon self
  end

  def to_ember_hash
    attributes.merge children: children.map(&:id)
  end

  private
  def _create_permalink
    self.permalink ||= Apiv1::Permalinkifier.permalinkify taxon_name
  end
  def _create_root_genus
    self.root_genus ||= parent.try :root_genus
    self.root_genus ||= Apiv1::Permalinkifier.permalinkify taxon_name
  end
  def _inform_parent
    parent.try :have_first_child!
  end
end
