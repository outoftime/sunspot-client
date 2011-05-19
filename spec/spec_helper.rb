require 'rspec'

# Support
require File.join(File.dirname(__FILE__), 'support', 'mock_query_helper')

RSpec.configure do |config|
  config.include Sunspot::MockQueryHelper
end
