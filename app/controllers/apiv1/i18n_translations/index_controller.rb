class Apiv1::I18nTranslations::IndexController < ApplicationController
  def index
    render json: { translations: _translations, locale: _locale }
  end
  private
  def _translations
    { _locale.to_s => _key_value_hash }
  end
  def _locale
    params[:locale].present? ? params[:locale] : I18n.locale
  end
  def _key_value_hash
    Apiv1::Translation.locale(_locale).map(&:tl_hash).reduce(&:merge)
  end
end