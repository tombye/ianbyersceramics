require 'yaml'
require 'erb'

module SiteData
  class Gallery
    attr_reader :id, :name, :slug, :photo_artwork, :index

    def initialize(index)
      @data_dir = Pathname.new(File.expand_path('../../../_data', __FILE__))
      @templates_dir = Pathname.new(File.expand_path('../../templates', __FILE__))
      @index = index.to_i
      @_data = load()

      unless @_data.nil?
        @id = @_data['id']
        @name = @_data['name']
        @photo_artwork = @_data['photo_artwork']
        @slug = @_data['slug']
      else
        puts "No gallery found for index: '#{index}'"
      end
    end

    def artworks 
      @_data['artworks']
    end

    def template_str
      str = ''
      File.read(@templates_dir.join('gallery.yml.erb'))
    end

    def render
      ERB.new(template_str).result(binding)
    end

  private

    def load()
      galleries = YAML.load_file(@data_dir.join('galleries.yml'))
      galleries[@index]
    end
  end
end
