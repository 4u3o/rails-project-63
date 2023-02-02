# frozen_string_literal: true

module Tag
  SINGLE_TAGS = %w[br hr input img].freeze

  def self.build_attributes(attrs)
    attrs.each_with_object([]) do |(k, v), acc|
      acc << " #{k}=\"#{v}\"" unless v.nil?
    end.join
  end

  def self.create_opening_tag(name, **attrs)
    "<#{name}#{build_attributes(attrs)}>"
  end

  def self.create_content(&block)
    block_given? ? block.call : ''
  end

  def self.create_closing_tag(name)
    SINGLE_TAGS.include?(name) ? '' : "</#{name}>"
  end

  def self.build(name, **attrs, &)
    [
      create_opening_tag(name, **attrs),
      create_content(&),
      create_closing_tag(name)
    ].join
  end
end
