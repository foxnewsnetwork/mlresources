class AddDeletedAtToApiv1OfferMessages < ActiveRecord::Migration
  def change
    add_column :apiv1_offer_messages, :deleted_at, :datetime
  end
end
