class Apiv1::Users::CreateController < Apiv1::HomeController
  def create
    if _user.valid?
      _user.save! && auto_login(_user)
      render json: { user: _user.to_ember_hash }
    else
      render json: _user.errors.to_h, status: :expectation_failed
    end
  end
  private
  def _user
    @user ||= Admin::User.new _user_params
  end
  def _user_params
    params.require(:user).permit :email, :company_name, :phone_number, :password, :password_confirmation, :address
  end
end