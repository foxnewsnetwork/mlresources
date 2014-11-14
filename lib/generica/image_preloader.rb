require 'tilt'
require 'erb'
module Generica; end
class Generica::ImagePreloader
  include Thor::Base
  include Thor::Actions

  def write_preloader_js_file
    create_file _destination, _file_contents
  end
  private
  def _destination
    Rails.root.join "vendor", "assets", "javascripts", "generica", "image-preload.js"
  end
  def _file_contents
    _template.render _context
  end
  def _template
    @template ||= Tilt::ERBTemplate.new _source
  end
  def _source
    @source ||= File.join __dir__, "image-preload.js.erb"
  end
  def _context
    @context ||= Context.new
  end
end

class Generica::ImagePreloader::Context
  def file_image_urls
    _css_files.map { |file| _get_image_urls_from_file.call file }.flatten.uniq
  end
  private
  def _css_files
    Dir.glob(Rails.root.join "app", "assets", "stylesheets", "**", "*").reject { |f| Dir.exists? f }
  end
  def _get_image_urls_from_file
    _filename_to_string >> _string_to_raw_css_urls >> _clean_css_urls
  end
  def _filename_to_string
    -> (file) { File.read file }
  end
  def _string_to_raw_css_urls
    -> (string) { string.to_s.scan /url\(*[a-z0-9_\-\s,\/]+\.[a-z]*\)/i }
  end
  def _clean_css_urls
    -> (css_urls) { css_urls.map { |css_url| _clean_css_url.call css_url } }
  end
  def _clean_css_url
    _clean_front_css_url >> _clean_rear_css_url >> _append_asset_path
  end
  def _append_asset_path
    -> (url) { File.join "assets", url }
  end
  def _clean_front_css_url
    -> (css_url) { css_url.gsub /^url\(('|")*/i, "" }
  end
  def _clean_rear_css_url
    -> (css_url) { css_url.gsub /('|")*\)$/, "" }
  end
end