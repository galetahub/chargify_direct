require_relative '../../test/helper'
require 'uri'

describe ChargifyDirect::RequestParameters do
  before do
    @request_parameters = ChargifyDirect::RequestParameters.new("ID", "SECRET")
    @signature = @request_parameters.signature
  end

  describe ".timestamp" do
    it "generates timestamp as an integer" do
      timestamp = @request_parameters.timestamp
      timestamp.must_be_kind_of Integer
      # Just in case
      Time.at(timestamp).must_be :>, Time.at(0)
    end
  end

  describe ".raw_data=" do
    describe "when invalid arguments are provided" do
      it "raises an ArgumentError if argument is not Hash" do
        -> {
          @request_parameters.raw_data = "DEFINITELY NOT A HASH RIGHT?"
        }.must_raise ArgumentError
      end
    end

    describe "when valid arguments are provided" do
      it "updates data instance variable with an url encoded string" do
        @request_parameters.raw_data = { cat: "meow" }
        data = @request_parameters.data
        data.must_be_kind_of String
        valid_url_with_query = "http://example.com/?#{data}"
        URI.parse(valid_url_with_query).query.must_equal(data)
      end
    end
  end

  describe ".nonce" do
    it "generates uuid string and doesn't cache it" do
      @request_parameters.nonce.must_be_kind_of String
      @request_parameters.nonce.wont_equal @request_parameters.nonce
    end
  end

  describe ".signature" do
    it "generates signature from supplied params" do
      @request_parameters.signature.wont_be_empty
    end

    it "generates exact same signature for same set of params" do
      @request_parameters.signature.must_equal @signature
    end

    it "generates different hash when params change" do
      signature = @request_parameters.signature
      @request_parameters.raw_data = { cat: "meow!" }
      signature.wont_equal @request_parameters.signature
    end
  end

  describe ".to_h" do
    it "presents request parameters as a hash" do
      puts @request_parameters.to_h.values.inspect
      @request_parameters.to_h.must_be_instance_of Hash
    end
  end
end
