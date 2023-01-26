# frozen_string_literal: true

require 'test_helper'

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  def setup
    @user = User.new name: 'rob', job: 'hexlet'
  end

  def test_that_build_returns_single_tag
    expected = '<br>'
    result = HexletCode::Tag.build('br')

    assert_equal expected, result
  end

  def test_that_build_returns_single_tag_with_attrs
    expected = '<img src="path/to/image">'
    result = HexletCode::Tag.build('img', src: 'path/to/image')

    assert_equal expected, result
  end

  def test_that_build_returns_tag_with_text
    expected = '<label for="email">Email</label>'
    result = HexletCode::Tag.build('label', for: 'email') { 'Email' }

    assert_equal expected, result
  end

  def test_that_build_returns_tag_without_attrs_and_text
    expected = '<div></div>'
    result = HexletCode::Tag.build('div')

    assert_equal expected, result
  end

  def test_that_form_for_returns_form
    expected = '<form action="#" method="post"></form>'

    result = HexletCode.form_for @user

    assert_equal expected, result
  end

  def test_that_form_for_returns_form_with_action
    expected = '<form action="/users" method="post"></form>'
    result = HexletCode.form_for @user, url: '/users'

    assert_equal expected, result
  end

  def test_that_form_for_returns_form_with_block
    fixture = File.new(
      "#{__dir__}/fixtures/form_with_input_and_textaria.html", 'r'
    )
    expected = fixture.read
    fixture.close

    result = HexletCode.form_for @user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text
    end

    assert_equal expected, result
  end

  def test_that_form_change_default_input_attrs
    fixture = File.new(
      "#{__dir__}/fixtures/form_with_changed_default_attrs.html"
    )
    expected = fixture.read
    fixture.close

    result = HexletCode.form_for @user, url: '#' do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    assert_equal expected, result
  end

  def test_that_inputs_value_with_nil_dont_show
    fixture = File.new(
      "#{__dir__}/fixtures/form_with_nil_value_input.html"
    )
    expected = fixture.read
    fixture.close

    result = HexletCode.form_for @user do |f|
      f.input :gender
    end

    assert_equal expected, result
  end

  def test_that_form_raise_error_if_user_didnt_have_attr
    assert_raises NoMethodError do
      HexletCode.form_for @user, url: '/users' do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
      end
    end
  end

  def test_submit_with_default_value
    fixture = File.new(
      "#{__dir__}/fixtures/form_with_submit_button.html"
    )
    expected = fixture.read
    fixture.close

    result = HexletCode.form_for @user, &:submit

    assert_equal expected, result
  end

  def test_submit_with_custom_value
    fixture = File.new(
      "#{__dir__}/fixtures/form_with_custom_submit_button.html"
    )
    expected = fixture.read
    fixture.close

    result = HexletCode.form_for @user do |f|
      f.submit 'wow'
    end

    assert_equal expected, result
  end
end
