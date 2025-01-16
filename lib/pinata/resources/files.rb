# frozen_string_literal: true

module Pinata
  class FilesResource < Resource
    def upload(file:, group_id: nil, name: nil, mime_type: nil, metadata: nil)
      validate(file: file)
      mime_type ||= Marcel::MimeType.for(file)
      payload = {file: Faraday::UploadIO.new(file, mime_type)}
      payload[:name] = name unless name.nil?
      payload[:group_id] = group_id unless group_id.nil?
      payload[:keyvalues] = metadata unless metadata.nil?
      File.new upload_post_request("files", body: payload,
        headers: {"Content-Type" => "multipart/form-data"}).body["data"]
    end

    def list(**params)
      response = api_get_request("files", params: params)
      Collection.from_response(response, key: "files", type: File)
    end

    def get(file_id:)
      File.new api_get_request("files/#{file_id}").body.dig("data")
    end

    def sign(gateway:, file_cid:, expires:, date: Time.now.to_i,
      url_method: "GET")
      payload = {
        url: "https://#{gateway}/files/#{file_cid}",
        date: date,
        expires: expires,
        method: url_method
      }
      api_post_request("files/sign", body: payload).body["data"]
    end

    def update(file_id:, **attributes)
      File.new api_put_request("files/#{file_id}", body: attributes).body["data"]
    end

    def delete(file_id:)
      File.new api_delete_request("files/#{file_id}").body.dig("data")
    end

    def validate(file:)
      raise ArgumentError, "`file` is required" if file.nil?
    end
  end
end
