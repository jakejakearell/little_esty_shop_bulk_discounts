Discount.destroy_all
InvoiceItem.destroy_all
Item.destroy_all
Merchant.destroy_all
Invoice.destroy_all
Customer.destroy_all

merchant1 = Merchant.create!(name: 'Hair Care')

item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
item_2 = Item.create!(name: "conditioner", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
item_3 = Item.create!(name: "face stuff", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
item_4 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)

customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
customer_3 = Customer.create!(first_name: 'Josh', last_name: 'Schultz')

invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
invoice_2 = Invoice.create!(customer_id: customer_3.id, status: 2, created_at: "2012-03-27 14:54:09")

ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 15, unit_price: 10, status: 2)
ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 5, unit_price: 1, status: 2)
ii_3 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 2, unit_price: 5, status: 2)
ii_4 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_4.id, quantity: 4, unit_price: 6, status: 2)
ii_5 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_4.id, quantity: 4, unit_price: 6, status: 2)

merchant2 = Merchant.create!(name: 'Dogs R U')

item_5 = Item.create!(name: "Dog Food", description: "Feed this to a dog", unit_price: 10, merchant_id: merchant2.id, status: 1)
item_6 = Item.create!(name: "Dog collar", description: "Put it on your dog", unit_price: 10, merchant_id: merchant2.id, status: 1)
item_7 = Item.create!(name: "dog stuff", description: "Idk, but dogs love this", unit_price: 10, merchant_id: merchant2.id, status: 1)
item_8 = Item.create!(name: "Treats", description: "Dog Treats", unit_price: 5, merchant_id: merchant2.id)

customer_2 = Customer.create!(first_name: 'Jimmy', last_name: 'Smitz')
customer_4 = Customer.create!(first_name: 'Jimmy', last_name: 'Smitz')

invoice_3 = Invoice.create!(customer_id: customer_2.id, status: 2, created_at: "2012-03-27 14:54:09")
invoice_4 = Invoice.create!(customer_id: customer_4.id, status: 2, created_at: "2012-03-27 14:54:09")

ii_6 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_5.id, quantity: 10, unit_price: 3, status: 2)
ii_7 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_6.id, quantity: 2, unit_price: 15, status: 2)
ii_8 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_7.id, quantity: 5, unit_price: 9, status: 2)
ii_9 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_8.id, quantity: 5, unit_price: 1, status: 2)
ii_10 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_8.id, quantity: 15, unit_price: 1, status: 2)
