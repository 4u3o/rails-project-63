# frozen_string_literal: true

autoload :Element, 'hexlet_code/element'

class InputElement < Element
  DEFAULT_TYPE = 'text'

  def initialize(**attrs, &)
    super('input', **attrs, &)
    @attrs[:type] ||= InputElement::DEFAULT_TYPE
  end
end
