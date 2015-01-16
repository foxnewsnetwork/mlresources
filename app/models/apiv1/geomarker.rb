# == Schema Information
#
# Table name: apiv1_geomarkers
#
#  id         :integer          not null, primary key
#  place_id   :integer
#  place_type :string(255)
#  permalink  :string(255)
#  longitude  :decimal(10, )
#  latitude   :decimal(10, )
#  created_at :datetime
#  updated_at :datetime
#

class Apiv1::Geomarker < ActiveRecord::Base
  class << self
    def find_by_ip(ip)
      find_by_permalink ip
    end
  end
  belongs_to :place,
    polymorphic: true

  geocoded_by :permalink
  after_validation :_consider_geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :_consider_reverse_geocode

  def coordinates
    [latitude, longitude]
  end

  def to_ember_hash
    {
      longitude: longitude,
      latitude: latitude
    }
  end

  def address=(a)
    write_attribute(:permalink, a)
  end

  def address
    read_attribute(:permalink)
  end
  private
  def _consider_geocode
    geocode unless geocoded?
  end
  def _consider_reverse_geocode
    reverse_geocode if permalink.blank?
  end
end
