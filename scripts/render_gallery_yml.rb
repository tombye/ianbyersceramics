#!/usr/bin/env ruby

require 'erb'
require_relative './site_data/gallery'
require_relative './site_data/artwork'

galleries_dir = Pathname.new(File.expand_path('../../galleries', __FILE__))
templates_dir = Pathname.new(File.expand_path('../templates', __FILE__))
if ARGV[0].nil?
  puts "No gallery index provided."
else
  slug = ARGV[0]
  gallery = SiteData::Gallery.new(slug)

  # render gallery index into root and /artworks root
  gallery_index_path = galleries_dir.join("#{gallery.slug}", "index.html")
  artworks_index_path = galleries_dir.join("#{gallery.slug}", "artworks", "index.html")

  unless gallery_index_path.exist?
    File.open(gallery_index_path, "w+") do |f|
      f.write(gallery.render)
    end
    puts "#{gallery_index_path} created"
  else
    puts "#{gallery_index_path} already exists"
  end

  unless artworks_index_path.exist?
    File.open(artworks_index_path, "w+") do |f|
      f.write(gallery.render)
    end
    puts "#{artworks_index_path} created"
  else
    puts "#{artworks_index_path} already exists"
  end

  # make directories for all artworks in gallery
  artwork_paths = {}

  gallery.artworks.each do |artwork_index|
    artwork_paths[artwork_index] = galleries_dir.join("#{gallery.slug}", "artworks", "#{artwork_index + 1}")
  end

  require 'fileutils'
  artwork_paths.each do |artwork_index, artwork_path|
    artwork_photos_path = artwork_path.join("photos")

    unless artwork_photos_path.exist?
      FileUtils.mkdir_p(artwork_photos_path)
      puts "Created #{artwork_photos_path}"
    else
      puts "#{artwork_photos_path} already exists"
    end

  end

  # render artwork page into artwork root and /photos root
  artwork_paths.each do |artwork_index, artwork_path|
    artwork = SiteData::Artwork.new(artwork_index, gallery)
    artwork_index_path = artwork_path.join("index.html")
    artwork_photos_index_path = artwork_path.join("photos", "index.html")

    unless artwork_index_path.exist?
      File.open(artwork_index_path, "w+") do |f|
        f.write(artwork.render)
      end
      puts "#{artwork_index_path} created"
    else
      puts "#{artwork_index_path} already exists"
    end

    unless artwork_photos_index_path.exist?
      File.open(artwork_photos_index_path, "w+") do |f|
        f.write(artwork.render)
      end
      puts "#{artwork_photos_index_path} created"
    else
      puts "#{artwork_photos_index_path} already exists"
    end

    # render artwork page for each photo
    artwork.template_path = templates_dir.join("artwork_photo_set.yml.erb")
    artwork.photos.each_with_index do |photo, index|
      artwork_photo_dir = artwork_path.join("photos", "#{photo['id']}")
      artwork_photo_index_path = artwork_photo_dir.join("index.html")

      # set the selected photo to the index of this one
      artwork.artwork_photo = index

      unless artwork_photo_dir.exist?
        FileUtils.mkdir_p(artwork_photo_dir)
      else
        puts "#{artwork_photo_dir} already exists"
      end

      unless artwork_photo_index_path.exist?
        File.open(artwork_photo_index_path, "w+") do |f|
          f.write(artwork.render)
        end
        puts "#{artwork_photo_index_path} created"
      else
        puts "#{artwork_photo_index_path} already exists"
      end
    end
  end
end
