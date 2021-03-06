require "harvester_core/modifiers/abstract_modifier"
require "harvester_core/modifiers/mapper"
require "harvester_core/modifiers/range_selector"
require "harvester_core/modifiers/adder"
require "harvester_core/modifiers/extractor"
require "harvester_core/modifiers/finder_with"
require "harvester_core/modifiers/finder_without"
require "harvester_core/modifiers/splitter"
require "harvester_core/modifiers/truncator"
require "harvester_core/modifiers/date_parser"
require "harvester_core/modifiers/whitespace_stripper"
require "harvester_core/modifiers/html_stripper"
require "harvester_core/modifiers/joiner"


module HarvesterCore
  module Modifiers
    extend ::ActiveSupport::Concern
    
    def get(attribute_name)
      value = self.attributes[attribute_name]
      HarvesterCore::AttributeValue.new(value)
    end

    def compose(*args)
      options = args.extract_options!
      options[:separator] ||= ""

      values = []
      args.each do |v|
        if v.is_a?(HarvesterCore::AttributeValue) || v.is_a?(Array)
          values += v.to_a
        elsif v.is_a?(String)
          values << v
        end
      end

      HarvesterCore::AttributeValue.new(values.flatten.join(options[:separator]))
    end
  end
end