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
  unless gallery_index_path.exist?
    File.open(gallery_index_path, "w+") do |f|
      f.write(gallery.render)
    end
  else
    puts "#{gallery_index_path} already exists, exiting"
  end
end
