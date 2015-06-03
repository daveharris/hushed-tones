# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create!(name: 'Dave', email: 'dave@harris.org.nz', password: 'password')

Tag.create!(name: 'Ruby')
Tag.create!(name: 'Rails')

Post.create!(title: 'Ruby on Rails is the best Web Framework', 
             body: 'It is *simply the best*, _better than all the rest_', 
             user: User.last, tags: Tag.all)

Post.create!(title: "Ruby", 
             body: "Ruby is a pretty sweet langauge on it's own", 
             user: User.last, tags: [Tag.first])

Post.create!(title: "Rails", 
             body: "Rails has made ruby very popular recently", 
             user: User.last, tags: [Tag.last])
