class Apiv1::Translations::CreateController < Admin::BaseController

  def create
    if _save_successful?
      _translation.save!
      render json: { translation: _translation_hash }
    else
      render json: { translation: _failure_hash }, status: :expectation_failed
    end
  end

  private
  def _save_successful?
    _translation.valid? 
  end

  def _translation
    @translation ||= Apiv1::Translation.new _translation_params
  end

  def _translation_params
    params.require(:translation).permit(:key, :locale, :translated_text, :value)
  end

  def _translation_hash
    _translation.to_ember_hash
  end

  def _failure_hash
    _translation.errors.to_h
  end
end