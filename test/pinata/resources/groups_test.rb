# frozen_string_literal: true

require "test_helper"

class GroupsResourceTest < Minitest::Test
  def test_create
    body = {name: "Test Group", is_public: true}
    stub = stub_request("files/groups", method: :post, body: body, response: stub_response(fixture: "groups/create"))
    client = Pinata::Client.new(pinata_jwt: "fake", adapter: :test, stubs: stub)
    group = client.groups.create(**body)

    assert_equal Pinata::Group, group.class
    assert_equal "1234567890", group.id
    assert_equal "Test Group", group.name
    assert_equal true, group.is_public
  end

  def test_list
    stub = stub_request("files/groups", response: stub_response(fixture: "groups/list"))
    client = Pinata::Client.new(pinata_jwt: "fake", adapter: :test, stubs: stub)
    groups = client.groups.list

    assert_equal Pinata::Collection, groups.class
    assert_equal false, groups.empty?
    assert_equal 2, groups.data.size
    first_group = groups.data.first
    assert_equal Pinata::Group, first_group.class
    assert_equal "01934c6f-ec31-778c-96b7-111111111111", first_group.id
    assert_equal false, first_group.is_public
  end
end
