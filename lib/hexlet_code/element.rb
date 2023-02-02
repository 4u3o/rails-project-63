# frozen_string_literal: true

class Element
  attr_reader :tag, :attrs, :content

  def initialize(tag, **attrs, &block)
    @tag = tag
    @attrs = attrs
    @content = block.call if block_given?
  end

  def to_html
    opening_tag = Tag.create_opening_tag(@tag, **@attrs)
    content = @content
    closing_tag = Tag.create_closing_tag(@tag)

    "#{opening_tag}#{content}#{closing_tag}"
  end
end
