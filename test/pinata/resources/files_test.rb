# frozen_string_literal: true

require "test_helper"

class FilesResourceTest < Minitest::Test
  def test_list
    stub = stub_request("files", response: stub_response(fixture: "files/list"))
    client = Pinata::Client.new(pinata_jwt: "fake", adapter: :test, stubs: stub)
    files = client.files.list

    assert_equal Pinata::Collection, files.class
    assert_equal false, files.empty?
    assert_equal 2, files.data.size
    first_file = files.data.first
    assert_equal Pinata::File, first_file.class
    assert_equal "11111111111111111111111111111111111111111111111111111111111", first_file.cid
  end
end
