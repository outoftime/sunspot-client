require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'nokogiri'

# Asserts that a request updated a document in Solr.
#
#     last_request.should update_document
#     last_request.should update_document.with_xpath('/add/doc[1]/field[@name="id"], 'MyModel 5')
RSpec::Matchers.define :update_document do
  match do |request|
    is_update_request?(request) && xpath_matches?(request)
  end

  failure_message_for_should do |request|
    if !is_update_request?(request)
      "expected #{request.inspect} to be a solr update request"
    elsif !xpath_matches?(request)
      "expected #{request.body} to match specified xpath matchers"
    end
  end

  chain :with_xpath do |xpath, expected_value|
    @xpath_values ||= {}
    @xpath_values[xpath] = expected_value
  end

  define_method :xpath_matches? do |request|
    doc = Nokogiri::XML(request.body)
    (@xpath_values || {}).each do |xpath, expected_value|
      unless doc.xpath(xpath).any? { |node| node.content == expected_value }
        return false
      end
    end

    true
  end

  define_method :is_update_request? do |request|
    !request.nil? && request.method == 'POST' && request.path =~ %r!/update(\?|$)!
  end
end
