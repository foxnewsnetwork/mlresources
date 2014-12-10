class Apiv1::Contacts::IndexController < Apiv1::UsersController
  def index
    _search_index_process.call
  end
  private
  def _search_index_process
    _search_inputs >> (_consider_user_scope % Arrows::ID) >> _consider_primality >> _render_output
  end
  def _search_inputs
    Arrows.lift [_user, _search_params]
  end
  def _consider_user_scope
    Arrows.lift -> (user) { user.present? ? user.contacts : Apiv1::UserContact }
  end
  def _consider_primality
    Arrows.lift -> (x) { x.last[:primary].present? ? x.first.is_primary.order_by_primality.limit(1) : x.first }
  end
  def _render_output
    Arrows.lift -> (contacts) { render json: { contacts: contacts.map(&:to_ember_hash) } }
  end
  def _search_params
    params.permit(:primary, :user_id)
  end
  def _user
    Admin::User.find_by_id(_search_params[:user_id]) || current_user
  end
end