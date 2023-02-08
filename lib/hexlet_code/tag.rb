# frozen_string_literal: true

module Tag
  SINGLE_TAGS = %w[br hr input img].freeze

  def self.single?(name)
    SINGLE_TAGS.include?(name)
  end

  def self.build_attributes(attrs)
    attrs.each_with_object([]) do |(k, v), acc|
      acc << " #{k}=\"#{v}\"" unless v.nil?
    end.join
  end

  def self.create_opening_tag(name, **attrs)
    "<#{name}#{build_attributes(attrs)}>"
  end

  def self.create_content(&block)
    block.call if block_given?
  end

  def self.create_closing_tag(name)
    "</#{name}>"
  end

  def self.build(name, **attrs, &)
    opening_tag = create_opening_tag(name, **attrs)
    return opening_tag if single?(name)

    [
      opening_tag,
      create_content(&),
      create_closing_tag(name)
    ].join
  end
end
