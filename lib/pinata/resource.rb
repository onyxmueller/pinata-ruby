# frozen_string_literal: true

module Pinata
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def test_get_request(url)
      handle_response client.test_connection.get(url)
    end

    def upload_post_request(url, body:, headers: {})
      handle_response client.upload_connection.post(url, body, headers)
    end

    def api_get_request(url, params: {}, headers: {})
      handle_response client.api_connection.get(url, params, headers)
    end

    def api_post_request(url, body:, headers: {})
      handle_response client.api_connection.post(url, body, headers)
    end

    def api_patch_request(url, body:, headers: {})
      handle_response client.api_connection.patch(url, body, headers)
    end

    def api_put_request(url, body:, headers: {})
      handle_response client.api_connection.put(url, body, headers)
    end

    def api_delete_request(url, params: {}, headers: {})
      handle_response client.api_connection.delete(url, params, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body["error"]}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{response.body["error"]}"
      when 403
        raise Error, "You are not allowed to perform that action. #{response.body["error"]}"
      when 404
        raise Error, "No results were found for your request. #{response.body["error"]}"
      when 429
        raise Error, "Your request exceeded the API rate limit. #{response.body["error"]}"
      when 500
        raise Error, "We were unable to perform the request due to server-side problems. #{response.body["error"]}"
      when 503
        raise Error,
              "You have been rate limited for sending more than 20 requests per second. #{response.body["error"]}"
      end

      response
    end
  end
end
