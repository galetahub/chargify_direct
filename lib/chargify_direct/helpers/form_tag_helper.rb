require 'core_ext/hash'

module ChargifyDirect::Helpers
  module FormTagHelper
    def chargify_secure_params_tag(request_params, options = {})
      raise ArgumentError, "RequestParams instance is expected. Received #{request_params.class}" unless params.is_a?(::ChargifyDirect::RequestParameters)
      request_params.to_h.each do |k, v|
        hidden_field_tag("secure[#{k.to_s}]", v, options)
      end
    end
  end
end
