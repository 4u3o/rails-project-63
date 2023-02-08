# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Form, 'hexlet_code/form'

  def self.form_for(obj, url: '#', method: 'post', **attrs, &block)
    Form.new(obj, action: url, method:, **attrs, &block).to_html
  end
end
