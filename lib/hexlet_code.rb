# frozen_string_literal: true

require_relative "hexlet_code/version"

# Hexlet homework.
module HexletCode
  User = Struct.new(:name, :job, :gender, keyword_init: true)
  Form = Struct.new("Form", :for_obj, :opening_tag, :content, :closing_tag) do |_|
    def to_s
      opening_tag + content + closing_tag
    end

    def input(name, type: "text", cols: "20", rows: "40", **attrs)
      value = for_obj.public_send(name)

      self.content += (
        if attrs[:as] == :text
          Tag.build("textarea", name:, cols:, rows:) do
            value
          end
        else
          Tag.build("input", name:, type:, value:, **attrs)
        end
      )
    end
  end

  # Tag generates html tags.
  module Tag
    SINGLE_TAGS = %w[br hr input img].freeze

    def self.create(tag_name, **attrs, &block)
      attrs_str = attrs.each_with_object([]) do |(k, v), acc|
        acc << " #{k}=\"#{v}\""
      end.join

      opening_tag = "<#{tag_name}#{attrs_str}>"
      content = block_given? ? block.call : ""
      closing_tag = SINGLE_TAGS.include?(tag_name) ? "" : "</#{tag_name}>"

      [opening_tag, content, closing_tag]
    end

    def self.build(tag_name, **attrs, &block)
      create(tag_name, **attrs, &block).join
    end
  end

  def self.form_for(obj, url: "#", method: "post", &block)
    form = Form.new(obj, *Tag.create("form", action: url, method:))
    block.call(form)
    form.to_s
  end
end
