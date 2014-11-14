class Apiv1::Translations::UpdateController < Admin::BaseController

  def update
    if _update_successful?
      render json: { translation: _translation_hash }
    else
      render json: { translation: _failure_hash }, status: :expectation_failed
    end
  end

  private
  def _update_successful?
    _translation.valid? && _translation.save!
  end

  def _translation
    _raw_translation.tap { |t| t.assign_attributes _translation_params }
  end

  def _raw_translation
    @translation ||= Apiv1::Translation.find params[:id]
  end

  def _translation_params
    params.require(:translation).permit(:key, :locale, :translated_text, :value)
  end

  def _translation_hash
    _translation.attributes
  end

  def _failure_hash
    _translation.errors.to_h
  end
end