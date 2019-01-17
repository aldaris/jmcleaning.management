# frozen_string_literal: true

# custom component requires input group wrapper
module InputGroup
  def prepend
    span_tag = content_tag(:span, options[:prepend], class: 'input-group-text')
    template.content_tag(:div, span_tag, class: 'input-group-prepend')
  end

  def append
    span_tag = content_tag(:span, options[:append], class: 'input-group-text')
    template.content_tag(:div, span_tag, class: 'input-group-append')
  end
end

# Register the component in Simple Form.
SimpleForm.include_component(InputGroup)
