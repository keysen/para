module Para
  module Component
    module Subclassable
      extend ActiveSupport::Concern

      included do
        configurable_on :subclasses
      end

      def subclassable?
        @subclassable ||= subclass_names.length > 0
      end

      def subclassable_with?(class_name)
        subclassable? && class_name.in?(subclass_names)
      end

      def subclass_names
        @subclass_names ||= if (subclasses.present? && subclasses.is_a?(Array))
          subclasses
        else
          []
        end
      end
    end
  end
end
