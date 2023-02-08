# frozen_string_literal: true

module Elements
  class Element
    attr_reader :tag, :attrs, :content

    def initialize(tag, content, **attrs)
      @tag = tag
      @attrs = attrs
      @content = content
    end

    def to_html
      Tag.build(@tag, **@attrs) { @content }
    end
  end

  class LabelElement < Element
    def initialize(content, **attrs)
      super('label', content, **attrs)
    end
  end

  class TextElement < Element
    DEFAULT_ROWS = 40
    DEFAULT_COLS = 20

    def initialize(content, **attrs)
      super('textarea', content, **attrs)
      @attrs[:rows] ||= TextElement::DEFAULT_ROWS
      @attrs[:cols] ||= TextElement::DEFAULT_COLS
    end
  end

  class InputElement < Element
    DEFAULT_TYPE = 'text'

    def initialize(content, **attrs)
      super('input', content, **attrs)
      @attrs[:type] ||= InputElement::DEFAULT_TYPE
    end

    def to_html
      Tag.build(@tag, **@attrs, value: @content)
    end
  end
end
