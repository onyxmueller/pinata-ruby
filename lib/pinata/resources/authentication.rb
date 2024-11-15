# frozen_string_literal: true

module Pinata
  class AuthenticationResource < Resource
    def test
      test_get_request("data/testAuthentication")
    end
  end
end
