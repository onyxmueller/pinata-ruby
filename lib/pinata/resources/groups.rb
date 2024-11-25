# frozen_string_literal: true

module Pinata
  class GroupsResource < Resource
    def create(name:, is_public: false)
      payload = {
        name: name,
        is_public: is_public
      }
      Group.new api_post_request("files/groups", body: payload).body["data"]
    end

    def get(group_id:)
      Group.new api_get_request("files/groups/#{group_id}").body.dig("data")
    end

    def list(**params)
      response = api_get_request("files/groups", params: params)
      Collection.from_response(response, key: "groups", type: Group)
    end

    def add_file(group_id:, file_id:)
      Group.new api_put_request("files/groups/#{group_id}/ids/#{file_id}").body["data"]
    end

    def remove_file(group_id:, file_id:)
      Group.new api_delete_request("files/groups/#{group_id}/ids/#{file_id}").body["data"]
    end

    def update(group_id:, **attributes)
      Group.new api_put_request("files/groups/#{group_id}", body: attributes).body["data"]
    end

    def delete(group_id:)
      Group.new api_delete_request("files/groups/#{group_id}").body.dig("data")
    end
  end
end
