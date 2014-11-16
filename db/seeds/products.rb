def _pic(name)
  Rack::Test::UploadedFile.new(Rails.root.join("public", "tests", "#{name}.png"), "image/png")
end
user = Admin::User.first
product_maker = user.products if user.present?
product_maker ||= Apiv1::Product
phash = {
  sku: "alpha-001",
  material: "doge",
  price: "5000 usd / doge",
  amount: "5000 dogs",
  place: "Los Angeles Pound",
  others: "great for memes"
}

product = product_maker.new phash
product.pictures.new pic: _pic("dog")
product.pictures.new pic: _pic("husky")
user.save! if user.present?
product.save!

phash = {
  sku: "alpha-002",
  material: "husky",
  price: "5000 usd / dog",
  amount: "5000 dogs",
  place: "Los Angeles Pound",
  others: "great for running and hunting"
}
product = product_maker.new phash
product.pictures.new pic: _pic("husky")
product.pictures.new pic: _pic("dog")
user.save! if user.present?
product.save!