def _pic(name)
  Rack::Test::UploadedFile.new(Rails.root.join("public", "tests", "#{name}.png"), "image/png")
end
# Test stuff
phash = {
  sku: "alpha-001",
  material: "doge",
  price: "5000 usd / doge",
  amount: "5000 dogs",
  place: "Los Angeles Pound",
  others: "great for memes"
}

product = Apiv1::Product.new phash
product.pictures.new pic: _pic("dog")
product.pictures.new pic: _pic("husky")
product.save!

phash = {
  sku: "alpha-002",
  material: "husky",
  price: "5000 usd / dog",
  amount: "5000 dogs",
  place: "Los Angeles Pound",
  others: "great for running and hunting"
}
product = Apiv1::Product.new phash
product.pictures.new pic: _pic("husky")
product.pictures.new pic: _pic("dog")
product.save!