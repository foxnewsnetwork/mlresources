class I18n::Backend::ActiveRecord
  include Singleton
  include I18n::Backend::Base
  include I18n::Backend::Flatten
  include I18n::Backend::Memoize
  include I18n::Backend::Cache
  def available_locales
    begin
      ::Apiv1::Translation.available_locales
    rescue ::ActiveRecord::StatementInvalid
      []
    end
  end

  def store_translations(locale, data, options = {})
    escape = options.fetch(:escape, true)
    flatten_translations(locale, data, escape, false).each do |key, value|
      ::Apiv1::Translation.locale(locale).lookup(expand_keys(key)).delete_all
      ::Apiv1::Translation.create(:locale => locale.to_s, :key => key.to_s, :value => value)
    end
  end

  private

  def lookup(locale, key, scope = [], options = {})
    key = normalize_flat_keys(locale, key, scope, options[:separator])
    result = ::Apiv1::Translation.locale(locale).lookup(key)

    if result.empty?
      nil
    elsif result.first.key == key
      result.first.value
    else
      chop_range = (key.size + I18n::Backend::Flatten::FLATTEN_SEPARATOR.size)..-1
      result = result.inject({}) do |hash, r|
        hash[r.key.slice(chop_range)] = r.value
        hash
      end
      result.deep_symbolize_keys
    end
  end

  # For a key :'foo.bar.baz' return ['foo', 'foo.bar', 'foo.bar.baz']
  def expand_keys(key)
    key.to_s.split(I18n::Backend::Flatten::FLATTEN_SEPARATOR).inject([]) do |keys, key|
      keys << [keys.last, key].compact.join(I18n::Backend::Flatten::FLATTEN_SEPARATOR)
    end
  end
end