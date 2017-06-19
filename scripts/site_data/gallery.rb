require 'yaml'

module SiteData
  class Gallery
    attr_reader :id, :name, :slug, :photo_artwork

    def initialize(slug)
      @data_dir = Pathname.new(File.expand_path('../../../_data', __FILE__))
      @slug = slug
      @_data = load()

      unless @_data.nil?
        @id = @_data['id']
        @name = @_data['name']
        @photo_artwork = @_data['photo_artwork']
      else
        puts "No gallery found for slug: '#{slug}'"
      end
    end

    def photos
      @_data['photos']
    end

  private

    def load()
      galleries = YAML.load_file(@data_dir.join('galleries.yml'))
      match = galleries.select do |gallery|
        gallery['slug'] == @slug
      end
      match[0]
    end
  end
end
