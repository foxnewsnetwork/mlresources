class Apiv1::Users::ShowController < Apiv1::HomeController
  def show
    render json: { user: _user_hash }
  end
  private
  def _user_hash
    _user.to_ember_hash
  end
  def _user
    @user ||= Admin::User.find params[:id]
  end
end