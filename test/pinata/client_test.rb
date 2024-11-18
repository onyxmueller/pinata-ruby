require "test_helper"

class ClientTest < Minitest::Test
  def test_api_key
    client = Pinata::Client.new pinata_jwt: "test"
    assert_equal "test", client.pinata_jwt
  end
end
