# frozen_string_literal: true

class Form
  autoload :LabelElement, 'hexlet_code/elements/label_element'
  autoload :TextareaElement, 'hexlet_code/elements/textarea_element'
  autoload :InputElement, 'hexlet_code/elements/input_element'

  attr_reader :tag, :attrs, :elements

  def initialize(obj, **attrs, &block)
    @tag = 'form'
    @attrs = attrs
    @obj = obj
    @elements = []
    block.call(self) if block_given?
  end

  def input(field_name, as: :input, **attrs)
    value = @obj.public_send(field_name)

    @elements << LabelElement.new(for: field_name) { field_name.capitalize }
    # Не понимаю как динамически резолвить класс Элемента,
    # ведь конструкторы принимают разный набор аргументов
    @elements << case as
                 when :input
                   InputElement.new(name: field_name, value:, **attrs)
                 when :text
                   TextareaElement.new(name: field_name, **attrs) { value }
                 else
                   raise 'undefined "as" parameter for input'
                 end
  end

  def submit(value = 'Save', **attrs)
    @elements << InputElement.new(type: 'submit', value:, **attrs)
  end
end
