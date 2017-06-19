#!/usr/bin/env ruby

require 'erb'
require_relative './site_data/gallery'

galleries_dir = Pathname.new(File.expand_path('../../galleries', __FILE__))
if ARGV[0].nil?
  puts "No gallery index provided."
else
  slug = ARGV[0]
  gallery = SiteData::Gallery.new(slug)

  # render gallery index into root and /artworks root
  gallery_index_path = galleries_dir.join("#{gallery.slug}", "index.html")
  artwork_index_path = galleries_dir.join("#{gallery.slug}", "artworks", "index.html")

  unless gallery_index_path.exist?
    File.open(gallery_index_path, "w+") do |f|
      f.write(gallery.render)
    end
    puts "#{gallery_index_path} created"
  else
    puts "#{gallery_index_path} already exists"
  end

  unless artwork_index_path.exist?
    File.open(artwork_index_path, "w+") do |f|
      f.write(gallery.render)
    end
    puts "#{artwork_index_path} created"
  else
    puts "#{artwork_index_path} already exists"
  end

  # make directories for all artworks in gallery
  require 'fileutils'
  artwork_paths = {}
  gallery.artworks.each do |artwork_index|
    artwork_paths[artwork_index] = galleries_dir.join("#{gallery.slug}", "artworks", "#{artwork_index + 1}")
  end

  artwork_paths.each do |artwork_index, artwork_path|
    artwork_photos_path = artwork_path.join("photos")
    unless artwork_photos_path.exist?
      FileUtils.mkdir_p(artwork_photos_path)
      puts "Created #{artwork_photos_path}"
    else
      puts "#{artwork_photos_path} already exists"
    end
  end
end
