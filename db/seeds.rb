# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Company.destroy_all
Pitch.destroy_all
Slide.destroy_all

Company.create(name: 'WeFunder', description: 'Lorem ipsum')
Company.create(name: 'The Best Idea', description: 'Lorem ipsum')
Company.create(name: 'Unique Business', description: 'Lorem ipsum')
Company.create(name: 'New Tech Unicorn', description: 'Lorem ipsum')
Company.create(name: 'Number One Company', description: 'Lorem ipsum')
