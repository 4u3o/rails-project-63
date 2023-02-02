# frozen_string_literal: true

require_relative 'element'
require_relative 'elements/textarea_element'
require_relative 'elements/input_element'
require_relative 'elements/label_element'

class Form
  attr_reader :tag, :attrs, :elements

  def initialize(obj, **attrs, &block)
    @tag = 'form'
    @attrs = attrs
    @obj = obj
    @elements = []
    block.call(self) if block_given?
  end

  def input(field_name, **attrs)
    value = @obj.public_send(field_name)

    @elements << LabelElement.new(for: field_name) { field_name.capitalize }
    @elements << if attrs.delete(:as) == :text
                   TextareaElement.new(name: field_name, **attrs) { value }
                 else
                   InputElement.new(name: field_name, value:, **attrs)
                 end
  end

  def submit(value = 'Save', **attrs)
    @elements << InputElement.new(type: 'submit', value:, **attrs)
  end
end
