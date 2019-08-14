require('pg')

class PizzaOrder

  attr_accessor :quantity, :topping
  attr_reader :id, :customer_id

  def initialize( options )
    @customer_id = options['customer_id'].to_i
    @quantity = options['quantity'].to_i
    @topping = options['topping']
    @id = options['id'].to_i if options['id']
  end

  def save
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    # VALUES ('Luke', 'Skywalker', 2, 'Napoli')
    sql = "
      INSERT INTO pizza_orders
        (
          customer_id,
          quantity,
          topping
        )
      VALUES
      ($1, $2, $3)
      RETURNING *
    "
    values = [@customer_id, @quantity, @topping]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def PizzaOrder.all
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "SELECT * FROM pizza_orders"
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    db.close()
    return orders.map { |order| PizzaOrder.new(order)}
  end

  def PizzaOrder.delete_all
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "DELETE FROM pizza_orders"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "DELETE FROM pizza_orders WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "
      UPDATE pizza_orders
      SET (
        customer_id,
        quantity,
        topping
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4
    "
    values = [@customer_id, @quantity, @topping, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

end
