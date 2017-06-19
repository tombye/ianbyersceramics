#!/usr/bin/env ruby

require 'erb'
require_relative './site_data/gallery'

if ARGV[0].nil?
  puts "No gallery slug provided."
else
  slug = ARGV[0]
  gallery = SiteData::Gallery.new(slug)
  puts gallery.render
end
