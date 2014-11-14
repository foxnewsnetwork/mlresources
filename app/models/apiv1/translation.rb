# == Schema Information
#
# Table name: apiv1_translations
#
#  id             :integer          not null, primary key
#  locale         :string(255)      not null
#  key            :string(255)      not null
#  value          :text
#  interpolations :text
#  is_proc        :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#

class Apiv1::Translation < ActiveRecord::Base
  TRUTHY_CHAR = "\001".freeze
  FALSY_CHAR = "\002".freeze
  serialize :value
  serialize :interpolations, Array

  Languages = YAML.load(File.read Rails.root.join "config", "desired_languages.yml")["languages"]
  KnownLocales = Languages.keys
  include ::Elasticsearch::Model
  include ::Elasticsearch::Model::Callbacks
  class << self
    def known_languages
      select(:locale).uniq.map(&:locale).map(&:to_sym)
    end
    def locale(locale)
      where(:locale => locale.to_s)
    end

    def lookup(keys, *separator)
      column_name = connection.quote_column_name('key')
      keys = Array(keys).map! { |key| key.to_s }

      if separator.present?
        warn "[DEPRECATION] Giving a separator to lookup is deprecated. " <<
          "You can change the internal separator by overwriting FLATTEN_SEPARATOR."
      end

      namespace = "#{keys.last}#{I18n::Backend::Flatten::FLATTEN_SEPARATOR}%"
      where("#{column_name} IN (?) OR #{column_name} LIKE ?", keys, namespace)
    end

    def available_locales
      known_languages
    end
  end
  scope :order_alphabetically,
    -> { order "#{self.table_name}.key asc" }

  scope :by_locale,
    -> (l) { where locale: l }

  scope :by_key,
    -> (k) { where key: k }

  validates :locale,
    :key,
    :value,
    presence: true

  validates :locale,
    inclusion: { in: KnownLocales }

  def to_ember_hash
    { id: id, locale: locale, key: key, translated_text: translated_text, value: value }
  end
  def tl_hash
    { key => translated_text }
  end

  def as_indexed_json(options={})
    {
      key: key.to_s,
      enkey: key.to_s.split("_").join(" "),
      translated_text: translated_text
    }
  end

  def interpolates?(key)
    self.interpolations.include?(key) if self.interpolations
  end

  def translated_text
    read_attribute :value
  end

  def translated_text=(value)
    write_attribute(:value, value)
  end

  def value
    v = read_attribute(:value)
    if is_proc
      Kernel.eval(v)
    elsif v == FALSY_CHAR
      false
    elsif v == TRUTHY_CHAR
      true
    else
      v
    end
  end

  def value=(v)
    va = v
    if v === false
      va = FALSY_CHAR
    elsif v === true
      va = TRUTHY_CHAR
    end
    write_attribute(:value, va)
  end
end
