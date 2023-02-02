# frozen_string_literal: true

class LabelElement < Element
  def initialize(**attrs, &)
    super('label', **attrs, &)
  end
end
