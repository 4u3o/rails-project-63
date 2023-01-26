# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/form'

module HexletCode
  module Tag
    SINGLE_TAGS = %w[br hr input img].freeze

    def self.build_attributes(attrs)
      attrs.each_with_object([]) do |(k, v), acc|
        acc << " #{k}=\"#{v}\"" unless v.nil?
      end.join
    end

    def self.create_opening_tag(tag_name, **attrs)
      "<#{tag_name}#{build_attributes(attrs)}>"
    end

    def self.create_content(&block)
      block_given? ? block.call : ''
    end

    def self.create_closing_tag(tag_name)
      SINGLE_TAGS.include?(tag_name) ? '' : "</#{tag_name}>"
    end

    def self.build(tag_name, **attrs, &)
      [
        create_opening_tag(tag_name, **attrs),
        create_content(&),
        create_closing_tag(tag_name)
      ].join
    end
  end

  def self.to_html(form)
    opening = Tag.create_opening_tag(form.tag, **form.attrs)
    content = form.content.map do |elem|
      "\n  #{Tag.build(elem.tag, **elem.attrs) { elem.content }}"
    end.join
    closing_delimiter = (form.content.any? ? "\n" : '')
    closing = Tag.create_closing_tag(form.tag)

    "#{opening}#{content}#{closing_delimiter}#{closing}"
  end

  def self.form_for(obj, url: '#', method: 'post', **attrs, &block)
    form = Form.new(obj, action: url, method:, **attrs, &block)
    to_html(form)
  end
end
