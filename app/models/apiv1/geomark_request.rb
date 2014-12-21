# == Schema Information
#
# Table name: apiv1_geomark_requests
#
#  id           :integer          not null, primary key
#  place_id     :integer
#  place_type   :string(255)
#  permalink    :string(255)
#  slugstyle    :string(255)
#  attempted_at :datetime
#  failed_at    :datetime
#  succeed_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Apiv1::GeomarkRequest < ActiveRecord::Base
  belongs_to :place,
    polymorphic: true

  scope :successfully_finished,
    -> { where "#{self.table_name}.succeed_at is not null" }

  scope :in_progress,
    -> { havent_failed.havent_succeed.where "#{self.table_name}.attempted_at is not null" }

  scope :havent_failed,
    -> { where "#{self.table_name}.failed_at is null" }

  scope :havent_succeed,
    -> { where "#{self.table_name}.succeed_at is null"}

  scope :unattempted,
    -> { havent_succeed.havent_failed.where "#{self.table_name}.attempted_at is null" }

  scope :unattempted_oldest_first,
    -> { unattempted.oldest_first }

  scope :oldest_first,
    -> { order("#{self.table_name}.created_at asc" )}

  before_create :_normalize_address

  def we_try_now!
    update attempted_at: DateTime.now
  end

  def we_fail_now!
    update failed_at: DateTime.now, attempted_at: DateTime.now
  end

  def we_did_it!
    update succeed_at: DateTime.now, attempted_at: DateTime.now
  end

  private
  def _normalize_address
    self.permalink = Apiv1::Permalinkifier.normalize_address permalink if slugstyle == 'address'
  end
end