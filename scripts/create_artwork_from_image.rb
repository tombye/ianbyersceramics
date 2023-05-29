#!/usr/bin/env ruby

require 'yaml'

def get_indices_from_artworks_data(data)
  last_artwork = data.last
  indices = {
    :artwork => last_artwork["id"],
    :artwork_photo => last_artwork["photos"].last["id"]
  }
  return indices
end

if ARGV[0].nil?
  puts "No image provided."
else
  image_name = ARGV[0]
  artworks_data = YAML.load(File.read("./_data/artworks.yml"))
  last_indices = get_indices_from_artworks_data(artworks_data)

  new_artwork = {
    "id" => last_indices[:artwork] + 1,
    "artwork_photo" => 0,
    "artwork_name" => "Untitled",
    "dimensions" => "",
    "artwork_materials" => "",
    "photos" => [{
      "id" => last_indices[:artwork_photo] + 1,
      "photo_name" => "",
      "photo_date" => "",
      "photo_file" => image_name,
      "photo_credit" => ""
    }]
  }

  artworks_data.append(new_artwork)

  File.open("./_data/artworks.yml", "w+") do |f|
    f.write(artworks_data.to_yaml)
  end
end
