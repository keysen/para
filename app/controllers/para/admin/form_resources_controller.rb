require_dependency "para/application_controller"

module Para
  module Admin
    class FormResourcesController < Para::Admin::ResourcesController
      before_action :load_and_authorize_form
      after_action :attach_resource_to_component, only: [:create]

      # Include after resource loading to allow the concern to use the resource
      # in before_action hooks
      include Para::Admin::ResourceControllerConcerns

      private

      def attach_resource_to_component
        return unless resource.persisted?
        @component.resource = resource
        @component.save
      end

      def load_and_authorize_form
        loader = self.class.cancan_resource_class.new(
          self, :resource, parent: false, class: resource_model.name,
          singleton: true, through: :component, bypass_params_assignation: true
        )

        loader.load_and_authorize_resource
        instance_variable_set(:"@#{ resource_name }", @resource)
      end
    end
  end
end
