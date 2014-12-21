class Apiv1::Users::ShowController < Apiv1::HomeController
  def show
    render json: { user: _user_hash }
  end
  private
  def _user_hash
    _user.log_ip!(request.ip)
  end
  def _user
    @user ||= Admin::User.find params[:id]
  end
end