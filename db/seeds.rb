# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email:'email@email.com', password:'password')
3.times do 
  Loan.create(amount: 1000.00, firstPayment: '1994-12-05', name: "Marcel", store:"Loja 1", portion1: 250, portion2: 300, portion3: 240)
  Loan.create(amount: 1250.00, firstPayment: '1994-12-05', name: "José", store:"Loja 2", portion1: 250, portion2: 300, portion3: 240)
end