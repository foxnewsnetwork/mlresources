root_classifications = [:material, :quality, :form, :processing, :packaging, :location]

location_taxons = [
  { taxon_name: "Los Angeles" },
  { taxon_name: "San Diego" },
  { taxon_name: "Oakland" },
  { taxon_name: "Seattle" },
  { taxon_name: "Tacoma" },
  { taxon_name: "Chicago" },
  { taxon_name: "Houston" }
].map do |n|
  n.merge root_genus: :location
end

material_taxons = [
  { taxon_name: "pet", explanation: "Polyethylene terephthalate. Commonly used in drinking bottles. Also known as PETE."  },
  { taxon_name: "hdpe", explanation: "High-density polyethylene. Known for its high density. Used in anything requiring strength." },
  { taxon_name: "pvc", explanation: "Polyvinyl chloride. Comes in both rigid and flexible forms. Used in pipes, credit cards, etc." },
  { taxon_name: "ldpe", explanation: "Low-density polyethylene. Low density version of HDPE. Used in applications requiring flexibility." },
  { taxon_name: "pp", explanation: "Polypropylene. Chemically resistant. Used in ropes, packaging, textiles, and padding." },
  { taxon_name: "ps", explanation: "Polystyrene. Inexpensive resin per unit weight with low-melting point. Naturally transparent, but often colored." },
  { taxon_name: "pla", explanation: "Polylactic acid. Biodegradable aliphastic polyester from renewable resuorces such as corn starch." },
  { taxon_name: "abs", explanation: "Acrylonitrile butadiene styrene. Toxic when heated. Used in computers chasis, lego blocks, and other hard applications." }
].map do |n|
  n.merge  root_genus: :material 
end

quality_taxons = [
  { taxon_name: "virgin", explanation: "Factory-produced, usually from petroleum. Pure chemically and unused. Frequently pelletized." },
  { taxon_name: "natural", explanation: "Natural uncolored recycled plastics." },
  { taxon_name: "colored", explanation: "Recycled plastic with artifical added colors." },
  { taxon_name: "commingled", explanation: "Recycled product with different plastics alloyed together." },
  { taxon_name: "mixed", explanation: "Recycled plastics mixed together." }
].map do |n|
  n.merge root_genus: :quality
end

form_taxons = ["rigid", "bottle", "regrind", "flakes", "pellet", "purge", "supersack", "film", "rope"].map do |n|
  { root_genus: :form, taxon_name: n }
end

processing_taxons = ["hot-washed", "washed"].map do |n|
  { root_genus: :processing, taxon_name: n }
end

packaging_taxons = ["baled", "gaylord", "pallet", "supersack", "none"].map do |n|
  { root_genus: :packaging, taxon_name: n }
end

Apiv1::Taxon.create! location_taxons
Apiv1::Taxon.create! material_taxons
Apiv1::Taxon.create! quality_taxons
Apiv1::Taxon.create! form_taxons
Apiv1::Taxon.create! processing_taxons
Apiv1::Taxon.create! packaging_taxons

bottle = Apiv1::Taxon.find_by_permalink_genus! "bottle", "form"
bottle_types = ["pill", "shampoo", "soda"].map do |n|
  { root_genus: :form, taxon_name: n, parent: bottle }
end

film = Apiv1::Taxon.find_by_permalink_genus! "film", "form"
film_types = ["grade a", "grade b", "grade c", "grade d", "colored", "agricultural"].map do |n|
  { root_genus: :form, taxon_name: n, parent: film }
end

rope = Apiv1::Taxon.find_by_permalink_genus! "rope", "form"
rope_types = ["twine", "strap"].map do |n|
  { root_genus: :form, taxon_name: n, parent: rope }
end

colored = Apiv1::Taxon.find_by_permalink_genus! "colored", "quality"
colored_types = ["black", "blue", "red", "green", "white", "yellow"].map do |n|
  { root_genus: :quality, taxon_name: n, parent: colored }
end

Apiv1::Taxon.create! bottle_types
Apiv1::Taxon.create! film_types

Apiv1::Taxon.create! rope_types
Apiv1::Taxon.create! colored_types