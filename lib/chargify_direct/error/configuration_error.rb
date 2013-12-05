require 'chargify_direct/error'

module ChargifyDirect
  class Error
    class ConfigurationError < ::ArgumentError
    end
  end
end
