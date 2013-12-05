require 'chargify_direct/signature'
require 'chargify_direct/uri_encode'
require 'securerandom'

module ChargifyDirect
  class RequestParameters
    include URIEncode
    include Signature

    attr_reader :nonce, :data, :raw_data, :api_id, :api_secret

    def initialize(api_id, api_secret, raw_data = {})
      api_id, api_secret, raw_data = api_id, api_secret, raw_data
      generate_signature
    end

    def timestamp
      @timestamp = Time.now.to_i
    end

    def raw_data=(hash)
      raise ArgumentError, "Expected Hash, received #{hash.class}" unless hash.is_a? Hash
      @raw_data = hash
      @data = uri_encode_data(raw_data)
    end

    def nonce
      @nonce = SecureRandom.uuid
    end

    def signature
      generate_signature
    end

    def to_h
      { 
        api_id: api_id,
        timestamp: timestamp,
        nonce: nonce,
        data: data,
        signature: signature
      }
    end

    private

    def generate_signature
      @signature = generate_digest(api_secret, api_id, @timestamp, @nonce, @data)
    end
  end
end
