class Admin::BaseController < ApplicationController
  before_filter :_respond_with_unauthorized_json
  private
  def _respond_with_unauthorized_json
    unless logged_in?
      render json: { message: "login required" }, status: 401
    end
  end
end