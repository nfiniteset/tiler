require 'RMagick'
require 'json'

class Matcher

	def initialize(prefix)
		@prefix = prefix
		@image_dir = "source/images" 
		@data_dir = "source/javascripts/data"
	end

	def write_edge_data
		tile_set = { tiles: [] }

		Dir["#{@image_dir}/#{@prefix}_*.png"].each do |path|
			tile_set[:tiles] << {
				asset: File.basename(path),
				edges: process_edges(path)
			}
		end
		tile_set[:tileWidth] = (@sample_image.columns / 2).to_i
		tile_set[:tileHeight] = (@sample_image.rows / 2).to_i
		File.open("#{@data_dir}/#{@prefix}.json", 'w') do |f|
			f.puts tile_set.to_json
		end
	end

	def read_image(path)
		image = Magick::Image.read(path) do
			self.depth = 8
			self.colorspace = Magick::GRAYColorspace
		end.first
		@sample_image ||= image
		image
	end

	def process_edges(path)
		tile_image = read_image(path)
		north_pixels 	= tile_image.crop(Magick::NorthWestGravity,    tile_image.columns, 1).get_pixels(0,0,tile_image.columns, 1)
		south_pixels 	= tile_image.crop(Magick::SouthWestGravity,    tile_image.columns, 1).get_pixels(0,0,tile_image.columns, 1)
		east_pixels 	= tile_image.crop(Magick::NorthEastGravity, 1, tile_image.rows).get_pixels(0,0,1,    tile_image.rows)
		west_pixels 	= tile_image.crop(Magick::NorthWestGravity, 1, tile_image.rows).get_pixels(0,0,1,    tile_image.rows)
		{
			n: simplify_edge(north_pixels),
			e: simplify_edge(east_pixels),
			s: simplify_edge(south_pixels),
			w: simplify_edge(west_pixels)
		}
	end

	def simplify_edge(pixels, chunk_count = 8)
		averages = []
		slice_size = pixels.size / chunk_count
		pixels.each_slice(slice_size) do |slice|
			averages << slice.map(&:red).reduce(&:+) / slice.size
		end
		averages
	end

#	def compare(edge1, edge2)
#		matches = []
#		edge1.size.times do |i|
#			val1 = edge1[i]
#			val2 = edge2[i]
#			diff = (val2 - val1).abs
#			matches << diff if diff < 5000
#		end
#		p matches.inspect
#		matches.size * (1 / edge1.size)
#	end

end

class GreyscaleComparison
	def initialize(chunk_count = 8, threshold = 5000)
	end

	def simplify(pixels)
	end

	def compare(edge1, edge2)
	end
end

m = Matcher.new('colored_pencil')
m.write_edge_data
