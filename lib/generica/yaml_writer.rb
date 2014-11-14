require 'tilt'
require 'erb'
class Generica::YamlWriter
  include Thor::Base
  include Thor::Actions

  def write_files
    _known_locales.each do |locale|
      create_file _destination(locale), _file_contents(locale)
    end
  end
  private
  def _known_locales
    Apiv1::Translation.known_languages
  end
  def _destination(locale)
    Rails.root.join "config", "locales", "#{locale}.yml"
  end
  def _file_contents(locale)
    Generica::ContentWriter.new(locale).file_contents
  end
end

class Generica::ContentWriter
  attr_accessor :locale
  def initialize(locale)
    @locale = locale
  end
  def file_contents
    _template.render _context
  end
  private
  def _template
    @template ||= Tilt::ERBTemplate.new _source
  end
  def _source
    @source ||= File.join __dir__, "locale.yml.erb"
  end
  def _context
    @context ||= Generica::LocaleYamlContext.new locale
  end
end

class Generica::LocaleYamlContext
  attr_accessor :locale
  def initialize(locale)
    @locale = locale
  end

  def translations
    @translations ||= Apiv1::Translation.by_locale locale
  end

end