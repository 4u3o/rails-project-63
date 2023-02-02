# frozen_string_literal: true

class HTML
  autoload :Tag, 'hexlet_code/tag'

  def initialize(tag, elements, **attrs)
    @opening = Tag.create_opening_tag(tag, **attrs)
    @content = elements.map do |element|
      Tag.build(element.tag, **element.attrs) { element.content }
    end.join
    @closing = Tag.create_closing_tag(tag)
  end

  def to_s
    "#{@opening}#{@content}#{@closing}"
  end
end
