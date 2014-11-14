class Admin::Sessions::CreateController < ApplicationController
  class ShouldNeverGetHere < ::StandardError; end
  def create
    if _already_logged_in? || _login_success?
      render json: _session_hash
    else
      render json: _failure_hash, status: :unauthorized
    end
  end
  private
  def _already_logged_in?
    logged_in? && (@user = current_user)
  end
  def _login_success?
    @user = login(_session_params[:email], _session_params[:password], true)
  end
  def _session_params
    params.require(:admin_session).permit :email, :password, :remember_me
  end
  def _session_hash
    { admin_session: @user.to_ember_hash }
  end
  def _failure_hash
    return { admin_session: { email: "that email doesn't exist" } } unless _email_exists?
    return { admin_session: { password: "wrong password" } } if _wrong_password?
    raise ShouldNeverGetHere, "the email and password are both correct, but our server died"
  end
  def _email_exists?
    Admin::User.exists? email: _session_params[:email]
  end
  def _wrong_password?
    @user.blank?
  end
end