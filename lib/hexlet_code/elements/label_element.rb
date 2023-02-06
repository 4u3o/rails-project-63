# frozen_string_literal: true

autoload :Element, 'hexlet_code/element'

class LabelElement < Element
  def initialize(**attrs, &)
    super('label', **attrs, &)
  end
end
