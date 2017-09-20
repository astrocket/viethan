# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(
    display_name: 'Admin',
    email: "admin@viet.com",
    password: "123456",
    admin: true
)

messageboard = Thredded::Messageboard.create!(
    name: '자유게시판',
    slug: 'general',
    description: 'A board is not a board without some posts'
)

Thredded::TopicForm.new(
    title: 'My first topic',
    content: <<-MARKDOWN,
Hello **world**! :smile: This first post shows some of the Thredded default post
formatting functionality.

### Quote

> There is nothing either good or bad, but thinking makes it so.

### Image

![lime-cat](https://cloud.githubusercontent.com/assets/216339/19857777/2be75b1e-9f3c-11e6-9845-f30ceb4308a9.jpg)

### Video

https://www.youtube.com/watch?v=dQw4w9WgXcQ

### Table

| x | y | x ⊕ y |
|---|---|:-----:|
| 1 | 1 |   0   |
| 1 | 0 |   1   |
| 0 | 1 |   1   |
| 0 | 0 |   0   |

### Code

```ruby
puts 'Hello world'
```

Code highlighting can be enabled by installing the
[Markdown Coderay plugin](https://github.com/thredded/thredded-markdown_coderay).

BBCode support (e.g. [b]bold[/b]) can be enabled by installing the
[BBCode plugin](https://github.com/thredded/thredded-bbcode).

TeX Math support (e.g. $$\phi$$) can be enabled by installing the
[KaTeX plugin](https://github.com/thredded/thredded-markdown_katex).
    MARKDOWN
    user: admin,
    messageboard: messageboard
).save
