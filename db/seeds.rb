# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Customers
customer_1 = Customer.create(name: 'John Doe', email: 'himanshu60.k@gmail.com', contact: '9479351461')
customer_2 = Customer.create(name: 'Jane Smith', email: 'himanshu60.k@gmail.com', contact: '9479351461')

# Guarantors
guarentor_1 = Guarentor.create(name: 'Bob Johnson', email: 'himanshu60.k@gmail.com', contact: '9479351461', customer: customer_1)
guarentor_2 = Guarentor.create(name: 'Mary Brown', email: 'himanshu60.k@gmail.com', contact: '9479351461', customer: customer_2)

# Loans
loan_1 = Loan.create(customer: customer_1, amount: '500000', duration_year: 50, loan_type: 'personal', file_charge: 500, started_at: 2023/02/20)
loan_2 = Loan.create(customer: customer_2, amount: '500000', duration_year: 50, loan_type: 'personal', file_charge: 500, started_at: 2023/02/15)

# Addresses
address_1 = Address.create(addressable: customer_1, street: '123 Main St', city: 'Anytown', state: 'CA', zipcode: '12345')
address_2 = Address.create(addressable: customer_2, street: '456 Elm St', city: 'Othertown', state: 'NY', zipcode: '67890')
address_3 = Address.create(addressable: guarentor_1, street: '789 Oak St', city: 'Somewhere', state: 'TX', zipcode: '45678')
address_4 = Address.create(addressable: guarentor_2, street: '321 Pine St', city: 'Nowhere', state: 'FL', zipcode: '23456')


# Documents
document_1 = Document.create(documentable: customer_1, aadhar_card: '8888888888', pancard: 'imjpk1234')
document_2 = Document.create(documentable: customer_2, aadhar_card: '8888888888', pancard: 'imjpk1234')
document_3 = Document.create(documentable: guarentor_1, aadhar_card: '8888888888', pancard: 'imjpk1234')
document_4 = Document.create(documentable: guarentor_2, aadhar_card: '8888888888', pancard: 'imjpk1234')