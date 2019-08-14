require('pry')
require_relative('./models/pizza_order')
require_relative('./models/customer')

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new( { 'name' => 'Bob' } )
customer1.save()

order1 = PizzaOrder.new({
    'topping' => 'Pepperoni',
    'quantity' => 4,
    'customer_id' => customer1.id
})

order1.save()

binding.pry
nil
