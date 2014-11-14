namespace :assets do
  desc "Unretardifies all assets other than js and css files. But unretardify, I mean it removes the digest hash."
  task unretardify: :environment do
    require Rails.root.join "lib", "generica", "assets_unretardifier"
    Generica::AssetsUnretardifier.new.unretardify!
  end
end