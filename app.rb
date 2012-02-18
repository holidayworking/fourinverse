require 'bundler'
require 'sinatra/base'
require 'erb'
require 'quimby'

MAX_NUM_OF_PHOTO = 20

class Fourinverse < Sinatra::Base
  configure :production do
    not_found do
      'Not found'
    end
    error do
      'Error'
    end
  end

  get '/' do
    erb :index
  end

  get '/photos.json' do
    error unless params[:ll]


    foursquare = Foursquare::Base.new(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_CLIENT_SECRET'])

    result = []
    foursquare.venues.nearby(:ll => params[:ll]).each do |venue|
      venue.all_photos().each_with_index do |photo, i|
        url = photo.url
        photo.sizes['items'].each do |item|
          result << { :id => venue.id, :name => venue.name, :url => url, :thumbnail => item['url'] } if item['width'] == 300
        end
        break if (i >= 4 or result.size >= MAX_NUM_OF_PHOTO)
      end
      break if result.size >= MAX_NUM_OF_PHOTO
    end

    content_type :json
    result.to_json
  end
end
