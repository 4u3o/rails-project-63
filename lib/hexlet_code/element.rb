# frozen_string_literal: true

# Element represents element of web-form.
class Element
  attr_reader :tag, :attrs, :content

  def initialize(tag, **attrs, &block)
    @tag = tag
    @attrs = attrs
    @content = block_given? ? block.call : ""
  end
end
