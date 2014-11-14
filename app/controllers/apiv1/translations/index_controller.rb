class Apiv1::Translations::IndexController < Apiv1::HomeController
  def index
    render json: { translations: _translations.map(&:to_ember_hash), meta: _meta }
  end
  private
  def _meta
    _translation_machine.meta
  end

  def _translations
    _translation_machine.translations
  end

  def _translation_machine
    @translation_machine ||= Apiv1::TranslationMachine.new _query_params
  end

  def _query_params
    params.permit :page, :per, :locale, :key, :query
  end
    
end