require_relative '../db/db_connector'
require_relative './categories'

class Items
  attr_reader :id, :name, :price, :category

  def initialize(id ,name, price, category=nil)
    @id = id
    @name =  name
    @price = price
    @category = category
  end

  def set_name(name)
    @name = name
  end

  def set_price(price)
    @price = price
  end

  def set_category(category)
    @category = category
  end

  def insert_item
    return false unless valid?
    client = create_db_client
    client.query("INSERT INTO items (id,name,price) VALUES (#{@id},'#{@name}',#{@price})")
  end
  
  
  def update
    return false unless valid?
    client = create_db_client
    client.query("UPDATE items set name = '#{@name}', price = #{@price} where id = #{id}")
  end
  
  def delete
    client = create_db_client
    client.query("DELETE FROM items WHERE id = #{@id}")
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    true
  end

  def get_item_detail
    client = create_db_client
    rawData = client.query("select items.id as 'id', items.name as 'items_name', items.price, item_categories.category_id, categories.name as 'nama_category' from items
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      where items.id = #{@id}
      ")
    items = Array.new
    rawData.each do |data|
      category = Category.new({
        id: data["category_id"],
        name: data["nama_category"]
      })
      item = Items.new({
        id: id,
        name:  data["items_name"],
        price: data["price"],
        category: category
      })
      items.push(item)
    end
    items
  end

  def update_category
    client = create_db_client
    rawData = client.query("select items.id as 'id', items.name as 'items_name', items.price, item_categories.category_id, categories.name as 'nama_category' from items
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      where items.id = #{@id}
      ")
    rawData.each do |data|
      category = Category.new(
        data["category_id"],
        data["nama_category"]
      )
      @category = category
    end
  end

  def self.self_find_item(params)
    client = create_db_client
    client.query("SELECT * FROM items where id = #{params["id"].to_i}")
  end

  def self.next_id
    client = create_db_client
    id = client.query("SELECT MAX(Id) FROM items").each
    id[0]["MAX(Id)"] +=1
  end

  def self.get_items
    client = create_db_client
    rawData = client.query("select * from items")
    items = Array.new
      rawData.each do |data|
        item = Items.new(data["id"],data["name"],data["price"])
        items.push(item)
      end
    items
  end

  def self.get_items_with_categories
    client = create_db_client
    rawData = client.query("select items.id as 'no_item_id', items.name as 'nama_item', items.price, categories.name as 'nama_category', categories.id as 'category_id' from items 
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      order by items.id
      ")
    items = Array.new
    rawData.each do |data|
      category = Category.new(data["category_id"],data["nama_category"])
      item = Items.new(data["no_item_id"],data["nama_item"],data["price"],category
      )
      items.push(item)
    end
     items
  end
end

