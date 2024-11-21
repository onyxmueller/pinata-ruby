# frozen_string_literal: true

module Pinata
  class Client
    API_VERSION = "v3"
    BASE_DOMAIN = "pinata.cloud"
    API_BASE_URL = "https://api.#{BASE_DOMAIN}/"
    API_URL = "#{API_BASE_URL}#{API_VERSION}/"
    UPLOADS_URL = "https://uploads.#{BASE_DOMAIN}/#{API_VERSION}/"

    attr_reader :pinata_jwt, :adapter

    def initialize(pinata_jwt:, adapter: Faraday.default_adapter, stubs: nil)
      @pinata_jwt = pinata_jwt
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def authentication
      AuthenticationResource.new(self)
    end

    def files
      FilesResource.new(self)
    end

    def groups
      GroupsResource.new(self)
    end

    def test_connection
      @test_connection ||= Faraday.new(url: API_BASE_URL) do |conn|
        conn.request :authorization, :Bearer, pinata_jwt
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end

    def upload_connection
      @upload_connection ||= Faraday.new(url: UPLOADS_URL) do |conn|
        conn.request :authorization, :Bearer, pinata_jwt
        conn.request :multipart
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end

    def api_connection
      @api_connection ||= Faraday.new(url: API_URL) do |conn|
        conn.request :authorization, :Bearer, pinata_jwt
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end

    def inspect
      "#<Pinata::Client>"
    end
  end
end
