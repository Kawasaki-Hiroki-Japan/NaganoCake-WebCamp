# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8

admin = Admin.new(
  email: "admin@nagano.cake.com",
  password: "nagano-cake"
)
admin.save!
end_user = EndUser.new(
  email: "admin@nagano.cake.com",
  password: "nagano-cake"
)
end_user.save!
Genre.create(name: "ケーキ", status: true)
Genre.create(name: "プリン", status: true)
Genre.create(name: "焼き菓子", status: true)
Genre.create(name: "キャンディ", status: true)
