root_classifications = [:material, :quality, :location].map { |n| { taxon_name: n } }
roots = Apiv1::Taxon.create! root_classifications
location = roots.last

location_taxons = [
  { taxon_name: "Los Angeles" },
  { taxon_name: "San Diego" },
  { taxon_name: "Oakland" },
  { taxon_name: "Seattle" },
  { taxon_name: "Tacoma" },
  { taxon_name: "Chicago" },
  { taxon_name: "Houston" }
].map do |n|
  n.merge parent: location
end

material = roots.first
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
  n.merge  parent: material
end

quality = roots.second
quality_taxons = [
  { taxon_name: "virgin", explanation: "Factory-produced, usually from petroleum. Pure chemically and unused. Frequently pelletized." },
  { taxon_name: "natural", explanation: "Natural uncolored recycled plastics." },
  { taxon_name: "colored", explanation: "Recycled plastic with artifical added colors." },
  { taxon_name: "commingled", explanation: "Recycled product with different plastics alloyed together." },
  { taxon_name: "mixed", explanation: "Recycled plastics mixed together." }
].map do |n|
  n.merge parent: quality
end


Apiv1::Taxon.create! location_taxons
Apiv1::Taxon.create! material_taxons
Apiv1::Taxon.create! quality_taxons

