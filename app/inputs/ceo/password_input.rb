require 'simple_form'

module CEO
  class PasswordInput < SimpleForm::Inputs::PasswordInput
    def input_html_classes
      super.push('input')
    end
  end
end
