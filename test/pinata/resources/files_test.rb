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

  def test_get
    file_id = "31d8fd7e-3a24-4e71-a1ad-d5fb8c035b38"
    stub = stub_request("files/#{file_id}", response: stub_response(fixture: "files/get"))
    client = Pinata::Client.new(pinata_jwt: "fake", adapter: :test, stubs: stub)
    file = client.files.get(file_id: file_id)

    assert_equal Pinata::File, file.class
    assert_equal file_id, file.id
    assert_equal "IMG_1234.jpg", file.name
    assert_equal "11111111111111111111111111111111111111111111111111111111111", file.cid
    assert_equal "image/jpeg", file.mime_type
  end

  def test_delete
    file_id = "31d8fd7e-3a24-4e71-a1ad-d5fb8c035b38"
    stub = stub_request("files/#{file_id}", method: :delete, response: stub_response(fixture: "files/delete"))
    client = Pinata::Client.new(pinata_jwt: "fake", adapter: :test, stubs: stub)
    assert client.files.delete(file_id: file_id)
  end
end
