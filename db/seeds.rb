# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Customers
require 'faker'

100.times do
  customer = Customer.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    contact: Faker::PhoneNumber.phone_number
  )

  # create a random address for the customer
  Address.create(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip_code,
    addressable: customer
  )

  # create a random document for the customer
  Document.create(
    aadhar_card: Faker::IDNumber.valid,
    pancard: Faker::IDNumber.valid,
    documentable: customer
  )

  guarentor = Guarentor.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    contact: Faker::PhoneNumber.phone_number,
    customer: customer,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
  )

  # create a random address for the customer
  Address.create(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zipcode: Faker::Address.zip_code,
    addressable: guarentor
  )

  # create a random document for the customer
  Document.create(
    aadhar_card: Faker::IDNumber.valid,
    pancard: Faker::IDNumber.valid,
    documentable: guarentor
  )

    Loan.create(
      amount: Faker::Number.between(from: 10000, to: 1000000),
      
      status: "pending",
      customer: customer,
      created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
      duration_year: Faker::Number.between(from: 1, to: 10),
      
      started_at: Faker::Date.between(from: Date.today - 6.months, to: Date.today),
      
      file_charge: Faker::Number.between(from: 500, to: 5000),
      loan_type: 'personal',
      
    )
end


  