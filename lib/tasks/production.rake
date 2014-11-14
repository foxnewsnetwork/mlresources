namespace :production do
  desc "These tasks should be run once on a virgin fresh installation"
  task virgin: :environment do
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end

  desc "These tasks should be run everytime you restart the server"
  task on_restart: :environment do
    Rake::Task["production:image_preload"].invoke
    Rake::Task["assets:clobber"].invoke
    Rake::Task["assets:precompile"].invoke
    Rake::Task["assets:unretardify"].invoke
    Rake::Task["elasticsearch:simple_import"].invoke
  end

  desc "generates the image-preload.js file"
  task image_preload: :environment do
    require Rails.root.join "lib", "generica", "image_preloader"
    Generica::ImagePreloader.new.write_preloader_js_file
  end
end