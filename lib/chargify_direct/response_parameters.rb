require 'chargify_direct/signature'

module ChargifyDirect
  class ResponseParameters < Struct.new(:api_id, :secret, :timestamp, :nonce,
                                        :status_code, :result_code, :call_id, :signature)
    include Signature

    def signature_verified?
      generate_digest(secret, api_id, timestamp, nonce, status_code, result_code, call_id) == signature
    end

    def success?
      status_code.to_s == '200'
    end
  end
end
