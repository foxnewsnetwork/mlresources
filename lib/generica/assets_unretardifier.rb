module Generica; end
class Generica::AssetsUnretardifier
  include Thor::Base
  include Thor::Actions
  source_root Rails.root.join("public", "assets")
  def unretardify!
    _retarded_files.each do |file|
      copy_file file[:original], _full_name(file[:destination])
    end
  end
  private
  def _full_name(short_name)
    Rails.root.join "public", "assets", short_name
  end
  def _files
    _manifest["files"].map do |original, file_hash|
      { original: original, destination: file_hash["logical_path"] }
    end
  end
  def _retarded_files
    _files.reject do |file_hash| 
      /(js|css)$/i =~ file_hash[:original]
    end
  end
  def _manifest
    return [] if _manifest_name.blank?
    JSON.parse File.read _manifest_name
  end
  def _manifest_name
    Dir[Rails.root.join("public", "assets", "manifest-*.json")].first
  end
end