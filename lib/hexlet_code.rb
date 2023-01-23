# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  # Tag
  class Tag
    SINGLE_TAGS = %w[br hr input img].freeze

    def self.build(tag_name, **attrs, &block)
      attrs_str = attrs.each_with_object([]) do |(k, v), acc|
        acc << " #{k}=\"#{v}\""
      end.join

      opening_tag = "<#{tag_name}#{attrs_str}>"
      text = block_given? ? block.call : ""
      closing_tag = SINGLE_TAGS.include?(tag_name) ? "" : "</#{tag_name}>"

      opening_tag + text + closing_tag
    end
  end
end
