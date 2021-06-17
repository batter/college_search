require 'roda'
require 'rack/indifferent'
require 'haml'
require 'httparty'
require 'pry-nav' unless ENV['RACK_ENV'] == 'production'

DATA_GOV_API_KEY = ENV['data_gov_api_key']
GOOGLE_MAPS_API_KEY = ENV['google_maps_api_key']
DATA_GOV_SCHOOL_BASE_URL = 'https://api.data.gov/ed/collegescorecard/v1/schools.json'.freeze

class App < Roda
  include HTTParty

  plugin :hooks
  plugin :render, engine: 'haml'
  plugin :json
  plugin :public
  plugin :environments
  plugin :indifferent_params
  plugin :assets, css: 'application.css', js: 'application.js', js_compressor: :uglifier

  def self.root
    @@root ||= Pathname.new(File.dirname(__FILE__))
  end

  compile_assets if production?

  # before hook runs before every request execution
  before do
    @payload = JSON.parse(request.env['rack.input'].read) rescue nil
  end

  route do |r|
    r.public
    r.assets unless ENV['RACK_ENV'] == 'production'

    # GET /
    r.root { view :index }

    r.post 'search' do
      query_string = Rack::Utils.build_query({
        api_key: DATA_GOV_API_KEY,
        _fields: 'id,school.name,location.lat,location.lon,school.state,school.city',
        'school.name' => params[:college][:name]
      })

      @results = self.class.get("#{DATA_GOV_SCHOOL_BASE_URL}?#{query_string}")['results']

      view :search
    end
  end
end
