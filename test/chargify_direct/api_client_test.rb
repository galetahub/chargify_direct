require_relative '../../test/helper'

describe ChargifyDirect::ApiClient do
  before do
    @client = ChargifyDirect::ApiClient.new(api_id: "ID", api_password: "PASS", api_secret: "SECRET")
  end

  describe ".new" do
    describe "when invalid credentials have been provided" do
      it "raises a ConfigurationError exception" do
        -> {
          ChargifyDirect::ApiClient.new(api_id: 42)
        }.must_raise ChargifyDirect::Error::ConfigurationError
      end
    end

    describe "when valid credentials have been provided" do
      it "creates RequestParameters instance" do
        @client.request_parameters.must_be_instance_of ChargifyDirect::RequestParameters
      end
    end

  end

  describe ".credentials" do
    it "returns credentials hash" do
      @client.credentials.must_be_instance_of Hash
    end
  end
end
