class Apiv1::Users::ProductFactory < Admin::ProductFactory
  delegate :save!,
    to: :user
  attr_accessor :user
  def initialize(user, input_params)
    @user = user
    super input_params
  end
  private
  def _product
    @product ||= user.products.new @params
  end
end