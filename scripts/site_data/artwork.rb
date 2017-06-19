module SiteData
  class Artwork
    attr_reader :id, :artwork_photo, :artwork_name, :dimensions, :artwork_materials

    def initialize(idx)
      @data_dir = Pathname.new(File.expand_path('../../../_data', __FILE__))
      @idx = idx.to_i
      @_data = load()

      unless @_data.nil?
        @id = @_data['id']
        @artwork_photo = @_data['artwork_photo']
        @artwork_name = @_data['artwork_name']
        @dimensions = @_data['dimensions']
        @artwork_materials = @_data['artwork_materials']
      else
        puts "No artwork found for index: '#{idx}'"
      end
    end

    def photos
      @_data['photos']
    end

  private

    def load()
      artworks = YAML.load_file(@data_dir.join('artworks.yml'))
      artworks[@idx]
    end
  end
end
