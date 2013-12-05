require 'uri'

module ChargifyDirect
  module URIEncode
    private

    def uri_encode_data(raw_data)
      build_nested_query(raw_data)
    end

    def build_nested_query(value, prefix = nil)
      case value
      when Array
        value.each_with_index.map { |v, i|
          build_nested_query(v, "#{prefix}[#{i}]")
        }.join("&")
      when Hash
        value.map { |k, v|
          build_nested_query(v, prefix ? "#{prefix}[#{escape(k)}]" : escape(k))
        }.join("&")
      when String
        raise ArgumentError, "value must be a Hash" if prefix.nil?
        "#{prefix}=#{escape(value)}"
      else
        prefix
      end
    end

    def escape(s)
      URI.encode_www_form_component(s)
    end
  end
end
