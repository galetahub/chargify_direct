require 'chargify_direct/request_parameters'

module ChargifyDirect
  class Client

    attr_reader   :request_parameters
    attr_accessor :api_id, :api_password, :api_secret

    def initialize(options = {}, &block)
      options.each do |key, value|
        send(:"#{key}=", value)
      end

      @request_parameters = RequestParameters.new(api_id, api_secret)
      yield self if block_given?
    end

    def credentials
      {
        api_id: api_id,
        api_password: api_password,
        api_secret: api_secret
      }
    end

    def credentials?
      credentials.values.all?
    end
  end
end
