# frozen_string_literal: true

autoload :Element, 'hexlet_code/element'

class TextareaElement < Element
  DEFAULT_ROWS = 40
  DEFAULT_COLS = 20

  def initialize(**attrs, &)
    super('textarea', **attrs, &)
    @attrs[:rows] ||= TextareaElement::DEFAULT_ROWS
    @attrs[:cols] ||= TextareaElement::DEFAULT_COLS
  end
end
