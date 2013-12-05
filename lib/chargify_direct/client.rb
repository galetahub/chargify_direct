require 'chargify_direct/request_parameters'

module ChargifyDirect
  class Client
    attr_reader   :request_parameters
    attr_accessor :api_id, :api_password, :api_secret

    def initialize(options = {}, &block)
      options.each do |key, value|
        send(:"#{key}=", value)
      end

      yield self if block_given?
      validate_credential_type!

      @request_parameters = RequestParameters.new(api_id, api_secret)
    end

    def credentials
      {
        api_id: api_id,
        api_password: api_password,
        api_secret: api_secret
      }
    end

    private

    def credentials?
      credentials.values.all?
    end

    def validate_credential_type!
      credentials.each do |credential, value|
        raise(Error::ConfigurationError, "api_id, api_secret and api_password must be specified.") unless credentials?
        raise(Error::ConfigurationError, "Invalid #{credential} specified: #{value.inspect} must be a string or symbol.") unless value.is_a?(String) || value.is_a?(Symbol)
      end
    end
  end
end
