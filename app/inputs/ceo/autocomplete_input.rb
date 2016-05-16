require 'simple_form'

module CEO
  class AutocompleteInput < SimpleForm::Inputs::AutocompleteInput
    def input_html_classes
      super.push('input')
    end
  end
end
