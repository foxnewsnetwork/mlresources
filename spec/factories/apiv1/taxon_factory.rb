# == Schema Information
#
# Table name: apiv1_taxons
#
#  id             :integer          not null, primary key
#  parent_id      :integer
#  root_genus     :string(255)      not null
#  taxon_name     :string(255)      not null
#  permalink      :string(255)      not null
#  explanation    :string(255)
#  first_child_at :datetime
#  created_at     :datetime
#  updated_at     :datetime
#

class Apiv1::TaxonFactory
  class << self
    def taxon_name
      @taxon_number ||= 0
      @taxon_number += 1
      [Faker::Name.first_name, @taxon_number.to_s].join " "
    end
    def material
      _c "material"
    end
    def location
      _c "location"
    end
    def quality
      _c "quality"
    end
    def form
      _c "form"
    end
    private
    def _c(m)
      Apiv1::Taxon.create! root_genus: m, taxon_name: taxon_name
    end
  end
end
