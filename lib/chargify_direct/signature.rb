require 'openssl'

module ChargifyDirect
  module Signature
    private

    def generate_digest(secret, *args)
      message = args.join("")
      sign(message, secret)
    end

    def sign(message, secret)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret, message)
    end
  end
end
