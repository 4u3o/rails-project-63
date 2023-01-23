# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  def setup
    @user = HexletCode::User.new name: "rob"
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_that_build_returns_single_tag
    expected = "<br>"
    result = HexletCode::Tag.build("br")

    assert_equal expected, result
  end

  def test_that_build_returns_single_tag_with_attrs
    expected = "<img src=\"path/to/image\">"
    result = HexletCode::Tag.build("img", src: "path/to/image")

    assert_equal expected, result
  end

  def test_that_build_returns_tag_with_text
    expected = "<label for=\"email\">Email</label>"
    result = HexletCode::Tag.build("label", for: "email") { "Email" }

    assert_equal expected, result
  end

  def test_that_build_returns_tag_without_attrs_and_text
    expected = "<div></div>"
    result = HexletCode::Tag.build("div")

    assert_equal expected, result
  end

  def test_that_form_for_returns_form
    expected = "<form action=\"#\" method=\"post\"></form>"

    result = HexletCode.form_for @user do |f|
    end

    assert_equal expected, result
  end

  def test_that_form_for_returns_form_with_action
    expected = "<form action=\"/users\" method=\"post\"></form>"

    result = HexletCode.form_for @user, url: "/users" do |f|
    end

    assert_equal expected, result
  end
end
