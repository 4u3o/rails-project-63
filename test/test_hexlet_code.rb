# frozen_string_literal: true

require 'test_helper'

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  def setup
    @user = User.new name: 'rob', job: 'hexlet'
  end

  def test_that_build_returns_single_tag
    expected = load_fixture('br.html')
    result = Tag.build('br')

    assert_equal expected, result
  end

  def test_that_build_returns_single_tag_with_attrs
    expected = load_fixture('img.html')
    result = Tag.build('img', src: 'path/to/image')

    assert_equal expected, result
  end

  def test_that_build_returns_tag_with_text
    expected = load_fixture('label_with_text.html')
    result = Tag.build('label', for: 'email') { 'Email' }

    assert_equal expected, result
  end

  def test_that_build_returns_tag_without_attrs_and_text
    expected = load_fixture('div.html')
    result = Tag.build('div')

    assert_equal expected, result
  end

  def test_that_form_for_returns_form
    expected = load_fixture('form.html')
    result = HexletCode.form_for @user

    assert_equal expected, result
  end

  def test_that_form_for_returns_form_with_action
    expected = load_fixture('form_with_action.html')
    result = HexletCode.form_for @user, url: '/users'

    assert_equal expected, result
  end

  def test_that_form_for_returns_form_with_block
    expected = load_fixture('form_with_input_and_textaria.html')
    result = HexletCode.form_for @user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text
    end

    assert_equal expected, result
  end

  def test_that_form_change_default_input_attrs
    expected = load_fixture('form_with_changed_default_attrs.html')
    result = HexletCode.form_for @user, url: '#' do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    assert_equal expected, result
  end

  def test_that_inputs_value_with_nil_dont_show
    expected = load_fixture('form_with_nil_value_input.html')
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
    expected = load_fixture('form_with_submit_button.html')
    result = HexletCode.form_for @user, &:submit

    assert_equal expected, result
  end

  def test_submit_with_custom_value
    expected = load_fixture('form_with_custom_submit_button.html')
    result = HexletCode.form_for @user do |f|
      f.submit 'wow'
    end

    assert_equal expected, result
  end
end
