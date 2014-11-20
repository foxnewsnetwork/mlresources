class Admin::Sessions::DestroyController < Apiv1::UsersController
  before_filter :_ensure_correct_sessionism
  def destroy
    logout
    render json: nil
  end
  private
  def _ensure_correct_sessionism
    unless current_user == _user
      render json: { message: "you can't log someone else out" }, status: 401
    end
  end
  def _user
    @user ||= Admin::User.find params[:id]
  end
end