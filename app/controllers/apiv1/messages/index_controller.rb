class Apiv1::Messages::IndexController < Admin::BaseController
  def index
    render json: { messages: _messages_hash, meta: _meta_hash }
  end
  private
  def _messages_hash
    _messages_machine.messages.map &:to_ember_hash
  end
  def _meta_hash
    _messages_machine.meta
  end
  def _messages_machine
    @messages_machine ||= Apiv1::MessagesMachine.new _query_params
  end
  def _query_params
    params.permit(:page, :per, :order)
  end
end