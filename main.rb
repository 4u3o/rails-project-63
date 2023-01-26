# frozen_string_literal: true

require_relative "lib/hexlet_code"

User = Struct.new(:name, :job, :gender, keyword_init: true)
new_user = User.new name: "Petr", gender: "Alpha-male"

form = HexletCode.form_for new_user, url: "/users" do |f|
  f.input :name
  f.input :age
  f.submit "Send"
end

puts form
