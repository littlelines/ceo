require 'simple_form'

module CEO
  class TextInput < SimpleForm::Inputs::TextInput
    def input_html_classes
      super.push('textarea')
    end
  end
end

