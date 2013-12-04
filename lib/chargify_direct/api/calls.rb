module ChargifyDirect::API
  module Calls
    def call(call_id)
      get("calls/#{call_id}")
    end
  end
end
