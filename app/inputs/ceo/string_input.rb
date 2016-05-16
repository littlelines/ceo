require 'simple_form'

module CEO
  class StringInput < SimpleForm::Inputs::StringInput
    def input_html_classes
      super.push('input')
    end
  end
end
