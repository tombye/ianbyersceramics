require 'yaml'
require 'liquid'

task :default do
  artworks = YAML.load(File.read('./_data/artworks.yml'))
  galleries = YAML.load(File.read('./_data/galleries.yml'))
  photos_source = "/Users/tombyers/Downloads/dad_covid_resources"
  photos_dest = "./public/images/gallery/photos"

  def render_index(template_name, file_name, params)
    File.open("./_templates/#{template_name}.rb", "r") do |template_file|
      template = Liquid::Template.parse(template_file.read)

      File.open(file_name, "w") do |index_file|
        index_file.write(template.render(**params))
      end 
    end
  end

  galleries.each_with_index do |gallery, gallery_index|
    if gallery['name'] == "Covid year"
      gallery_artworks = artworks.select.with_index do |artwork, index|
        gallery['artworks'].include? index
      end
      
      artworks_root = "./galleries/#{gallery['slug']}/artworks"
      new_artworks = false

      gallery_artworks.each_with_index do |artwork|
        artwork_index = artwork['id'].to_i - 1
        artwork_root = "#{artworks_root}/#{artwork['id']}"
        unless Dir.exists?(artwork_root)
          new_artworks = true
          Dir.mkdir(artwork_root)
          puts "make	#{artwork_root}"
          render_index(
            'artwork',
            "#{artwork_root}/index.html",
            {
              'gallery_index' => gallery_index,
              'artwork_index' => artwork_index
            }
          )
          puts "render	#{artwork_root}/index.html"
          Dir.mkdir("#{artwork_root}/photos")
          puts "make	#{artwork_root}/photos"
          FileUtils.cp "#{artwork_root}/index.html", "#{artwork_root}/photos/index.html"
          puts "copied	#{artwork_root}/index.html to #{artwork_root}/photos/index.html"

          artwork['photos'].each_with_index do |photo, photo_index|
            photo_root = "#{artwork_root}/photos/#{photo['id']}"
            photo_file = "#{photo['photo_file']}"

            Dir.mkdir("#{photo_root}")
            puts "make	#{photo_root}"
            render_index(
              'photo',
              "#{photo_root}/index.html",
              {
                'gallery_index' => gallery_index,
                'artwork_index' => artwork_index,
                'photo_index' => photo_index
              }
            )
            puts "render	#{photo_root}/index.html"

            if File.exists?("#{photos_source}/#{photo_file}")
              FileUtils.cp "#{photos_source}/#{photo_file}", "#{photos_dest}/#{photo_file}"
              FileUtils.cp "#{photos_source}/90x90/#{photo_file}", "#{photos_dest}/90x90/#{photo_file}"
              FileUtils.cp "#{photos_source}/200x200/#{photo_file}", "#{photos_dest}/200x200/#{photo_file}"
              FileUtils.cp "#{photos_source}/600x600/#{photo_file}", "#{photos_dest}/600x600/#{photo_file}"
              puts "copied	#{photos_source}/#{photo_file} to #{photos_dest}/#{photo_file}"
              puts "copied	#{photos_source}/90x90/#{photo_file} to #{photos_dest}/90x90/#{photo_file}"
              puts "copied	#{photos_source}/200x200/#{photo_file} to #{photos_dest}/200x200/#{photo_file}"
              puts "copied	#{photos_source}/600x600/#{photo_file} to #{photos_dest}/600x600/#{photo_file}"
            else
              puts "#{photo_file} referenced in data for artwork #{artwork['id']} but does not exist"
            end
          end
        end
      end

      puts "No new artworks added" unless new_artworks

      break
    end
  end
end
