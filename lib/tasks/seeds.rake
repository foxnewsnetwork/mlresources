namespace :seeds do
  desc "loads the translations living in db/seeds/translation_seeds"
  task translations: :environment do
    require Rails.root.join "db", "seeds", "translation_seeds"
  end

  ["dimensions", "products", "users"].each do |seeds|
    desc "seeds the database with the data living in db/seeds/#{seeds}.rb"
    task seeds => :environment do
      require Rails.root.join "db", "seeds", seeds
    end
  end
end