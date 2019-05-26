# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.all.each do |user|
  user.destroy
end
Loan.all.each do |loan|
  loan.destroy
end
User.create(email:'email@email.com', password:'password')

1.times do
	Customer.create(name:'Marcel')
	Customer.create(name:'Roberto')
end	
1.times do 
  Loan.create(customer_id: 1, amount: 1000.00, store:"Loja 1", portion1: 200, portion2: 200, portion3: 200, date_p1: DateTime.now + 70, date_p2: DateTime.now + 100, date_p3: DateTime.now + 130, paid_p1: true, paid_p2: false, paid_p3: false)
  Loan.create(customer_id: 1, amount: 1002.00, store:"Loja 1", portion1: 200, portion2: 200, portion3: 200, date_p1: DateTime.now + 70, date_p2: DateTime.now + 100, date_p3: DateTime.now + 130, paid_p1: true, paid_p2: false, paid_p3: false)
  Loan.create(customer_id: 1, amount: 1003.00, store:"Loja 1", portion1: 200, portion2: 200, portion3: 200, date_p1: DateTime.now + 70, date_p2: DateTime.now + 100, date_p3: DateTime.now + 130, paid_p1: true, paid_p2: false, paid_p3: false)
  Loan.create(customer_id: 1, amount: 1004.00, store:"Loja 1", portion1: 200, portion2: 200, portion3: 200, date_p1: DateTime.now + 70, date_p2: DateTime.now + 100, date_p3: DateTime.now + 130, paid_p1: true, paid_p2: false, paid_p3: false)
  Loan.create(customer_id: 2, amount: 1250.00, store:"Loja 2", portion1: 250, portion2: 250, portion3: 250, date_p1: DateTime.now + 70, date_p2: DateTime.now + 100, date_p3: DateTime.now + 130, paid_p1: true, paid_p2: true, paid_p3: false)
end



Loan.create(customer_id: 1, 
	amount: 600.00, 
	store:"Loja 1", 
	portion1: 200, 
	portion2: 200, 
	portion3: 200, 
	date_p1: DateTime.now + 100, 
	date_p2: DateTime.now + 130, 
	date_p3: DateTime.now + 160, 
	paid_p1: true, 
	paid_p2: false, 
	paid_p3: false)

Loan.create(customer_id: 1, 
	amount: 537.25, 
	store:"Loja 1", 
	portion1: 137.25, 
	portion2: 200, 
	portion3: 200, 
	date_p1: DateTime.now + 100, 
	date_p2: DateTime.now + 130, 
	date_p3: DateTime.now + 160, 
	paid_p1: true, 
	paid_p2: false, 
	paid_p3: false)

Loan.create(customer_id: 1, 
	amount: 537.25, 
	store:"Loja 1", 
	portion1: 137.25121212121212111112, 
	portion2: 200, 
	portion3: 200, 
	date_p1: DateTime.now + 100, 
	date_p2: DateTime.now + 130, 
	date_p3: DateTime.now + 160, 
	paid_p1: true, 
	paid_p2: false, 
	paid_p3: false)