module Para
  module AttributeField
    class BooleanField < AttributeField::Base
      field_option :wrapper, :wrapper_name

      def value_for(instance)
        I18n.t("para.types.boolean.#{ (!!instance.send(name)).to_s }")
      end

      private
      
      def wrapper_name
        :horizontal_radio_and_checkboxes
      end
    end
  end
end
