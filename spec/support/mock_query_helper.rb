require 'cgi'
require 'json'
require 'fakeweb'

module Sunspot
  module MockQueryHelper
    # Sets up a fixtured response for a Solr query.
    #
    #     // TODO: Make a reasonable example
    #     mock_query(:select, {:q => ...}, {:foo => :bar})
    #     mock_query(:dismax, {:q => ...}, nil, {:status => [500, 'Internal Server Error']})
    def mock_query(request_handler, params, json_response, options = {})
      # Defaults
      select_params = {:wt    => :json,
                       :start => 0,
                       :rows  => 30
                      }.merge(params)
      response_opts = {:body => JSON.dump(json_response)}.merge(options)

      query_string = as_sorted_query_string(select_params)
      FakeWeb.register_uri(:get, %r|/#{request_handler.to_s}\?#{query_string}|, response_opts)
    end

    # Returns the last request sent to Solr.  This is usually used with the
    # `have_updated_document` matcher.
    #
    #     last_request.should have_updated_document(...)
    def last_request
      FakeWeb.last_request
    end

    def mock_all_updates
      FakeWeb.register_uri(:post, %r|/update\?wt=ruby$|, :body => "{'responseHeader'=>{'status'=>0,'QTime'=>1}}")
    end

    private

    def as_sorted_query_string(params)
      params.keys.sort.inject([]) do |qs, key|
        value = params[key]
        qs << "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end
  end
end
