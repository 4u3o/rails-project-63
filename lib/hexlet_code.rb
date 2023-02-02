# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload :Form, 'hexlet_code/form'
  autoload :HTML, 'hexlet_code/html'

  def self.form_for(obj, url: '#', method: 'post', **attrs, &block)
    form = Form.new(obj, action: url, method:, **attrs, &block)
    HTML.new(form.tag, form.elements, **form.attrs).to_s
  end
end
