class AddRejectedAtToApiv1OfferMessages < ActiveRecord::Migration
  def change
    add_column :apiv1_offer_messages, :rejected_at, :datetime
  end
end
