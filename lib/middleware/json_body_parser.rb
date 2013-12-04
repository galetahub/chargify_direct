require 'multi_json'
require 'faraday'

module ChargifyDirect::Middleware
  class JsonBodyParser < ::Faraday::Response::Middleware
    def parse(body)
      case body
      when /\A^\s*$\z/, nil
        nil
      else
        MultiJson.load(body)
      end
    end

    def on_complete(env)
      if respond_to?(:parse)
        env[:body] = parse(env[:body]) unless unparsable_status_codes.include?(env[:status])
      end
    end

    private

    def unparsable_status_codes
      [204, 301, 302, 304]
    end
  end
end
