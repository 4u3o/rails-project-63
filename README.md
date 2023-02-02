### Hexlet tests and linter status:
[![Actions Status](https://github.com/4u3o/rails-project-63/workflows/hexlet-check/badge.svg)](https://github.com/4u3o/rails-project-63/actions)
[![Master Status](https://github.com/4u3o/rails-project-63/actions/workflows/master.yml/badge.svg)](https://github.com/4u3o/rails-project-63/actions)

# Генератор HTML форм

```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
new_user = User.new name: "Petr", gender: "Alpha-male"

form = HexletCode.form_for new_user, url: "/users" do |f|
  f.input :name, class: "perfect"
  f.input :job, as: :text
  f.submit "Send"
end

puts form
```

Cформирует следующую форму:
```html
<form action="/users" method="post">
  <label for="name">Name</label>
  <input name="name" type="text" value="Petr" class="perfect">
  <label for="job">Job</label>
  <textarea name="job" cols="20" rows="40"></textarea>
  <input type="submit" value="Send">
</form>
```

Если у юзера нет поля, указанного в блоке, то всплывет ошибка `NoMethodError`
```ruby
form = HexletCode.form_for new_user, url: "/users" do |f|
  f.input :name
  f.input :age
  f.submit "Send"
end
```
```txt
undefined method `age' for #<struct User name="Petr", job=nil, gender="Alpha-male"> (NoMethodError)
```

# Разработка

Команды:
 - `make install` - установить зависимости
 - `make test` - запустить тесты
 - `make lint` - запустить линтер
