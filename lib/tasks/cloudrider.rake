namespace :cloudrider do
  desc "Creates a default seed file using the google translate api"
  task make_translation_seed: :environment do
    require Rails.root.join "lib", "generica"
    Generica::SeedGenerator.new.write_file
  end
end
