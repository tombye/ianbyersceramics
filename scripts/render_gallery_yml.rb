#!/usr/bin/env ruby

require 'erb'
require_relative './site_data/gallery'
require_relative './site_data/artwork'

galleries_dir = Pathname.new(File.expand_path('../../galleries', __FILE__))
templates_dir = Pathname.new(File.expand_path('../templates', __FILE__))

def render_if_doesnt_exist(path, model)
  unless path.exist?
    File.open(path, "w+") do |f|
      f.write(model.render)
    end
    puts "#{path} created"
  else
    puts "#{path} already exists"
  end
end

def mkdir_if_doesnt_exist(path)
  unless path.exist?
    FileUtils.mkdir_p(path)
    puts "#{path} created"
  else
    puts "#{path} already exists"
  end
end

if ARGV[0].nil?
  puts "No gallery index provided."
else
  slug = ARGV[0]
  gallery = SiteData::Gallery.new(slug)

  # render gallery index into root and /artworks root
  gallery_index_path = galleries_dir.join("#{gallery.slug}", "index.html")
  artworks_index_path = galleries_dir.join("#{gallery.slug}", "artworks", "index.html")

  render_if_doesnt_exist(gallery_index_path, gallery)
  render_if_doesnt_exist(artworks_index_path, gallery)

  # make directories for all artworks in gallery
  artwork_paths = {}

  gallery.artworks.each do |artwork_index|
    artwork_paths[artwork_index] = galleries_dir.join("#{gallery.slug}", "artworks", "#{artwork_index + 1}")
  end

  require 'fileutils'
  artwork_paths.each do |artwork_index, artwork_path|
    artwork_photos_path = artwork_path.join("photos")
    mkdir_if_doesnt_exist(artwork_photos_path)
  end

  # render artwork page into artwork root and /photos root
  artwork_paths.each do |artwork_index, artwork_path|
    artwork = SiteData::Artwork.new(artwork_index, gallery)
    artwork_index_path = artwork_path.join("index.html")
    artwork_photos_index_path = artwork_path.join("photos", "index.html")

    # make indices for each artwork and its photos directory
    render_if_doesnt_exist(artwork_index_path, artwork)
    render_if_doesnt_exist(artwork_photos_index_path, artwork)

    # render artwork page for each photo
    artwork.template_path = templates_dir.join("artwork_photo_set.yml.erb")
    artwork.photos.each_with_index do |photo, index|
      artwork_photo_dir = artwork_path.join("photos", "#{photo['id']}")
      artwork_photo_index_path = artwork_photo_dir.join("index.html")

      # set the selected photo to the index of this one
      artwork.artwork_photo = index

      # make a directory and index for each artwork photo
      mkdir_if_doesnt_exist(artwork_photo_dir)
      render_if_doesnt_exist(artwork_photo_index_path, artwork)
    end
  end
end
