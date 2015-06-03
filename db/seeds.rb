# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create!(name: 'Dave', email: 'dave@harris.org.nz', password: 'password')
Post.create!(title: 'First Post', body: 'This is the *body* of the message', user: User.last)
