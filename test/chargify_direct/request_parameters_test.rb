require_relative '../../test/helper'
require 'uri'

describe ChargifyDirect::RequestParameters do
  before do
    @request_parameters = ChargifyDirect::RequestParameters.new("ID", "SECRET")
  end

  describe ".signature" do
    it "generates signature from supplied params" do
      @request_parameters.signature.wont_be_empty
    end

    it "generates exact same signature for same set of params" do
      @request_parameters.signature.must_equal @request_parameters.signature
    end

    it "generates different hash when params change" do
      signature = @request_parameters.signature
      @request_parameters.raw_data = { cat: "meow!" }
      signature.wont_equal @request_parameters.signature
    end
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
          @request_parameters.raw_data = "NOT A HASH RIGHT?"
        }.must_raise ArgumentError
      end
    end

    describe "when valid arguments are provided" do
      it "updates data instance variable with an url encoded string" do
        @request_parameters.raw_data = { cat: "meow" }
        @request_parameters.data.must_be_kind_of String
        valid_url_with_query = "http://example.com/?#{@request_parameters.data}"
        URI.parse(valid_url_with_query).query.must_equal(data)
      end
    end
  end
end
