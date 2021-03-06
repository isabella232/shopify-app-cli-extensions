# frozen_string_literal: true

module Script
  module Forms
    class Create < ScriptForm
      flag_arguments :extension_point, :name

      def ask
        self.name = (name || ask_name).downcase.gsub(' ', '_')
        self.extension_point ||= ask_extension_point
      end

      private

      def ask_extension_point
        CLI::UI::Prompt.ask(
          @ctx.message('script.forms.create.select_extension_point'),
          options: Script::Layers::Application::ExtensionPoints.types
        )
      end

      def ask_name
        name = CLI::UI::Prompt.ask(@ctx.message('script.forms.create.script_name'))
        return name if name.match?(/^[0-9A-Za-z _-]*$/)
        @ctx.abort(@ctx.message('script.forms.create.error.invalid_name'))
      end
    end
  end
end
