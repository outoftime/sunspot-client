require 'rspec'

# Support
require File.join(File.dirname(__FILE__), 'support', 'mock_query_helper')

RSpec.configure do |config|
  config.include Sunspot::MockQueryHelper

  config.before do
    FakeWeb.allow_net_connect = false

    mock_all_updates
  end

  config.after do
    FakeWeb.clean_registry
  end
end
