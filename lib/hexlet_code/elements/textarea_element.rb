# frozen_string_literal: true

class TextareaElement < Element
  def initialize(**attrs, &)
    super('textarea', **attrs, &)
    @attrs[:rows] ||= '40'
    @attrs[:cols] ||= '20'
  end
end
