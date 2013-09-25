module HarvesterCore
  module Modifiers
    class Extractor < AbstractModifier

      attr_reader :original_value, :regexp

      def initialize(original_value, regexp)
        @original_value, @regexp = original_value, regexp
      end

      def modify
        original_value.map do |value|
          value.match(regexp).try(:[], 1)
        end.compact
      end
    end
  end
end