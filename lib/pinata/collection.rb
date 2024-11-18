# frozen_string_literal: true

module Pinata
  class Collection
    attr_reader :data, :next_page_token

    def self.from_response(response, key:, type:)
      body = response.body
      new(
        data: body["data"][key].map { |attrs| type.new(attrs) },
        next_page_token: body.dig("data", "next_page_token")
      )
    end

    def initialize(data:, next_page_token:)
      @data = data
      @next_page_token = (next_page_token.nil? || next_page_token.empty?) ? nil : next_page_token
    end

    def empty?
      data.empty?
    end

    def sample
      data.sample
    end
  end
end
