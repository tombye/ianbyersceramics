module SiteData
  class Artwork
    attr_reader :id, :artwork_index, :artwork_name, :dimensions, :artwork_materials, :gallery_name, :gallery_slug, :gallery_index
    attr_accessor :artwork_photo, :template_path

    def initialize(idx, gallery)
      @data_dir = Pathname.new(File.expand_path('../../../_data', __FILE__))
      @templates_dir = Pathname.new(File.expand_path('../../templates', __FILE__))
      @template_path = @templates_dir.join('artwork.yml.erb')
      @artwork_index = idx.to_i
      @gallery_name = gallery.name
      @gallery_slug = gallery.slug
      @gallery_index = gallery.id - 1
      @_data = load()

      unless @_data.nil?
        @id = @_data['id']
        @artwork_photo = @_data['artwork_photo']
        @artwork_name = @_data['artwork_name']
        @dimensions = @_data['dimensions']
        @artwork_materials = @_data['artwork_materials']
      else
        puts "No artwork found for index: '#{artwork_index}'"
      end
    end

    def photos
      @_data['photos']
    end

    def template_str
      File.read(@template_path)
    end

    def render
      ERB.new(template_str).result(binding)
    end

  private

    def load()
      artworks = YAML.load_file(@data_dir.join('artworks.yml'))
      artworks[@artwork_index]
    end
  end
end
