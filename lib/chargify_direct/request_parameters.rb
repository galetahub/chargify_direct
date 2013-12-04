require 'chargify_direct/signature'
require 'chargify_direct/uri_encode'

module ChargifyDirect
  class RequestParameters < Struct.new(:api_id, :secret, :timestamp, :nonce, :data, :url_encoded_data)
    include URIEncode
    include Signature

    def signature
      generate_digest(secret, api_id, timestamp, nonce, data)
    end
  end
end
