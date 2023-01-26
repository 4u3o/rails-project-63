# frozen_string_literal: true

require_relative "element"

# Form represents web-form object.
class Form
  attr_reader :tag, :attrs, :content

  def initialize(obj, **attrs, &block)
    @obj = obj
    @tag = "form"
    @attrs = attrs
    @content = []
    block.call(self) if block_given?
  end

  def input(name, type: "text", cols: "20", rows: "40", **attrs)
    value = @obj.public_send(name)

    @content << Element.new("label", for: name) { name.capitalize }
    @content << if attrs[:as] == :text
                  Element.new("textarea", name:, cols:, rows:) { value }
                else
                  Element.new("input", name:, type:, value:, **attrs)
                end
  end

  def submit(value = "Save")
    @content << Element.new("input", type: "submit", value:)
  end
end
