require 'simple_form'

module CEO
  class DatepickerInput < SimpleForm::Inputs::Base
    def input(wrapper_options)
      @builder.text_field(attribute_name, input_html_options)
    end

    def input_html_options
      { class: 'input', id: 'date-input', datepicker: "" }
    end
  end
end
