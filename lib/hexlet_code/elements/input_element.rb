# frozen_string_literal: true

class InputElement < Element
  def initialize(**attrs, &)
    super('input', **attrs, &)
    @attrs[:type] ||= 'text'
  end
end
