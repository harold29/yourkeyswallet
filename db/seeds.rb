# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Currency.destroy_all

Currency.create!([{
  name: 'Bitcoin',
  code: 'BTC',
  symbol: '₿'
},
{
  name: 'Ethereum',
  code: 'ETH',
  symbol: 'Ξ'
}])

TransactionType.destroy_all

TransactionType.create!([{
  name: 'Payment',
  description: 'User 1 pays to User 2'
},
{
  name: 'Money Transfer',
  description: 'Wallet 1 moves money to Wallet 2'
}])
