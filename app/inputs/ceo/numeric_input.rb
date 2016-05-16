require 'simple_form'

module CEO
  class NumericInput < SimpleForm::Inputs::NumericInput
    def input_html_classes
      super.push('input')
    end
  end
end

