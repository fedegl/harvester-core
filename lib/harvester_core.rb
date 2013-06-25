require 'active_support/all'
require 'active_model'
require 'nokogiri'
require 'rest_client'
require 'jsonpath'
require 'chronic'

require "harvester_core/version"
require "harvester_core/exceptions"
require "harvester_core/utils"
require "harvester_core/scope"
require "harvester_core/xml_helpers"
require "harvester_core/attribute_value"
require "harvester_core/modifiers"
require "harvester_core/validations"
require "harvester_core/dsl"
require "harvester_core/base"
require "harvester_core/paginated_collection"
require "harvester_core/request"
require "harvester_core/attribute_builder"
require "harvester_core/enrichment"
require "harvester_core/resource"
require "harvester_core/source_wrap"
require "harvester_core/loader"

require "harvester_core/xml"
require "harvester_core/json"

module HarvesterCore
  # Your code goes here...

  class << self
    attr_accessor :caching_enabled
    attr_accessor :parser_base_path
    attr_accessor :redis_available

    def redis
      @redis ||= Redis.new
    end
  end
end