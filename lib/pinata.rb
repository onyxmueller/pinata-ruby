# frozen_string_literal: true

# Pinata Ruby bindings
# API spec at https://docs.pinata.cloud/api-reference/
require "faraday"
require "faraday/multipart"
require "marcel"
require "pinata/version"

module Pinata
  autoload :Client, "pinata/client"
  autoload :Collection, "pinata/collection"
  autoload :Error, "pinata/error"
  autoload :Resource, "pinata/resource"
  autoload :Object, "pinata/object"

  autoload :AuthenticationResource, "pinata/resources/authentication"
  autoload :FilesResource, "pinata/resources/files"

  autoload :File, "pinata/objects/file"
end
