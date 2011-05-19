require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'net/http'

describe Sunspot::MockQueryHelper do
  describe '#mock_query' do
    it 'mocks the query by registering it with FakeWeb' do
      json_response = {:foo => 'bar'}
      FakeWeb.should_receive(:register_uri).
              with(:get, %r|/select\?q=foo&rows=30&start=0&wt=json|, {:body => JSON.dump(json_response)})

      mock_query(:select, {:q => 'foo'}, json_response)
    end
  end

  describe '#last_request' do
    it 'returns the last request made' do
      request = Net::HTTP::Get.new('/')
      FakeWeb.should_receive(:last_request).and_return(request)

      last_request.should equal request
    end
  end
end
