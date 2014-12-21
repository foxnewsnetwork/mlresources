require 'generica/geomark_slave'
namespace :geomark_slave do
  desc "pulls out all the geomark_requests objects and attempts to fulfill them"
  task work_the_queue: :environment do
    puts "begin geocoding..."
    puts Generica::GeomarkSlave.geocode!.inspect
    puts "finished geocoding"
  end

  desc "queue up all the product listings which don't already have addresses"
  task queue_up_products: :environment do
    Apiv1::Product.all.map do |product|
      puts Apiv1::Geomarks::RequestJobManager.new(product).queue_job!
    end
  end

  desc "queue up the taxons which are of root genus location"
  task queue_up_taxons: :environment do
    Apiv1::Taxon.by_root_genus("location").map do |taxon|
      puts Apiv1::Geomarks::RequestJobManager.new(taxon).queue_job!
    end
  end
end