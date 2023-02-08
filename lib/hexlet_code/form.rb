# frozen_string_literal: true

class Form
  autoload :Elements, 'hexlet_code/elements'
  autoload :Tag, 'hexlet_code/tag'

  attr_reader :tag, :attrs, :elements

  def initialize(obj, **attrs, &block)
    @tag = 'form'
    @attrs = attrs
    @obj = obj
    @elements = []
    block.call(self) if block_given?
  end

  def input(field_name, as: :input, **attrs)
    raise 'undefined "as" attribute' unless %i[text input].include? as

    value = @obj.public_send(field_name)

    @elements << Elements::LabelElement.new(field_name.capitalize, for: field_name)
    @elements << Elements.const_get("#{as.capitalize}Element")
                         .new(value, name: field_name, **attrs)
  end

  def submit(value = 'Save', **attrs)
    @elements << Elements::InputElement.new(value, type: 'submit', **attrs)
  end

  def to_html
    Tag.build(@tag, **attrs) do
      elements.map(&:to_html).join
    end
  end
end
