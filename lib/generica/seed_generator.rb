require 'tilt'
require 'erb'
require 'painful_translate'

class Generica::SeedGenerator
  include Thor::Base
  include Thor::Actions
  def write_file
    create_file _destination, _file_content
  end
  private
  def _destination
    Rails.root.join "db", "seeds", "translation_seeds.rb"
  end
  def _file_content
    Generica::FileContentGenerator.new.contents
  end
end

class Generica::FileContentGenerator
  def contents
    _file_contents.join "\n\n"
  end
  private
  def _file_contents
    _target_languages.map do |language|
      Generica::TranslationContext.new language
    end.map do |ctx|
      Generica::FileMaker.new ctx
    end.map do |maker|
      maker.rendered_file_contents
    end
  end
  def _target_languages
    Generica::Languages.keys
  end
end

class Generica::FileMaker
  def initialize(context)
    @context = context
  end
  def rendered_file_contents
    _template.render @context
  end
  private
  def _template
    @template ||= Tilt::ERBTemplate.new _source
  end
  def _source
    @source ||= File.join __dir__, "translation_seeds.rb.erb"
  end
end

class Generica::TranslationContext
  attr_accessor :language
  def initialize(language)
    @language = language
  end

  def translations
    return _translations_for_just_english if language.to_s == "en"
    _translations_for_everything_other_than_english
  end
  private
  def _translations_for_just_english
    @translations ||= _matching_keys.zip(_strings_to_translate).map do |key_and_text|
      { locale: "en", key: key_and_text.first, translated_text: key_and_text.last }
    end
  end
  def _translations_for_everything_other_than_english
    @translations ||= _key_and_texts.map do |key_and_text|
      { locale: language, key: key_and_text.first, translated_text: key_and_text.last }
    end
  end
  def _key_and_texts
    _matching_keys.zip _translated_texts
  end
  def _translated_texts
    @translations = PainfulTranslate.translate _strings_to_translate, to: language, from: :en
  end
  def _matching_keys
    Generica::StringLoader.keys
  end
  def _strings_to_translate
    Generica::StringLoader.strings
  end
end

class Generica::StringLoader
  class << self
    def strings
      instance.strings
    end
    def keys
      instance.keys
    end
    def instance
      @instance ||= new
    end
  end
  def strings
    english.values
  end
  def keys
    english.keys
  end
  def english
    _hash["en"]
  end
  private
  def _hash
    @hash ||= YAML.load File.read Rails.root.join "lib", "generica", "seed.en.yml"
  end
end

module Generica
  Languages = YAML.load(File.read Rails.root.join "config", "desired_languages.yml")["languages"]
end