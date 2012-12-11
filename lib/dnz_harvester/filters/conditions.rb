module DnzHarvester
  module Filters
    class IfCondition
      include DnzHarvester::Filters::AttributeValues

      attr_reader :record, :new_value, :existing_values

      def initialize(record, new_value, existing_values)
        @record = record
        @new_value = *new_value
        @existing_values = *existing_values
      end

      def if_present(attribute_name)
        value_to_check = contents(attribute_name)

        if value_to_check.present?
          new_value + existing_values
        else
          existing_values
        end
      end
    end
  end
end
