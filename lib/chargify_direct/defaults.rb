require 'middleware/json_body_parser'

module ChargifyDirect
  module Defaults
    API_ENDPOINT = 'https://api.chargify.com/api/v2/'
    MEDIA_TYPE   = 'application/json'
    CONTENT_TYPE = 'application/x-www-form-urlencoded; charset=UTF-8'

    def connection_options
      @connection_options ||= {
        request: { request: :url_encoded },
        builder: middleware,
        headers: {
          accept: MEDIA_TYPE,
          content_type: CONTENT_TYPE
        }
      }
    end

    def middleware
      @middleware ||= ::Faraday::Builder.new do |builder|
        builder.use ChargifyDirect::Middleware::JsonBodyParser
        builder.adapter :em_http
      end
    end
  end
end
