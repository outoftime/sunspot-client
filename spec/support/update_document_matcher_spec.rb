require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'net/http'

describe 'update_document matcher' do
  describe 'basic operation' do
    it 'verifies the request is not nil' do
      nil.should_not update_document
    end

    it 'verifies the request is a document update request' do
      Net::HTTP::Post.new('/solr/update').should update_document
      Net::HTTP::Post.new('/solr/select').should_not update_document
    end
  end

  describe 'with_xpath' do
    let(:request) do
      request = Net::HTTP::Post.new('/solr/update')
      request.body = <<-EOD
        <?xml version=\"1.0\" encoding=\"UTF-8\"?>
        <add>
          <doc>
            <field name=\"id\">MyModel 5</field>
            <field name=\"type\">MyModel</field>
            <field name=\"type\">ActiveRecord::Base</field>
            <field name=\"class_name\">MyModel</field>
            <field name=\"blah_text\">blah blah blah</field>
          </doc>
        </add>
      EOD

      request
    end

    it 'matches the request body against xpath selectors' do
      request.should update_document.with_xpath('/add/doc[1]/field[@name="id"]', 'MyModel 5').
                                     with_xpath('/add/doc[1]/field[@name="type"]', 'MyModel')

      request.should_not update_document.with_xpath('/add/doc[1]/field[@name="id"]', 'NOTCORRECT')
    end
  end
end
