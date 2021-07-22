require_relative '../../db/mysql_connector'
require_relative '../categories/category'

class Items
  attr_reader :id, :name, :price, :category

  def initialize(id ,name, price, category=nil)
    @id = id
    @name =  name
    @price = price
    @category = category
  end

  def self.next_id
    client = create_db_client
    client.query("SELECT MAX(Id) FROM items")
  end

  def self.get_all_items
    client = create_db_client
    rawData = client.query("select * from items")
    items = Array.new
      rawData.each do |data|
        item = Items.new(data["id"],data["name"],data["price"])
        items.push(item)
      end
    items
  end
  
  def self.item(id)
    client = create_db_client
    rawData = client.query("select items.id as 'id', items.name as 'items_name', items.price, item_categories.category_id, categories.name as 'nama_category' from items
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      where items.id = #{id}
      ")
    items = Array.new
    rawData.each do |data|
      category = Category.new(data["category_id"],data["nama_category"])
      item = Items.new(id,data["items_name"],data["price"],category)
      items.push(item)
    end
    items
  end
  
  def self.get_all_items_with_categories
    client = create_db_client
    rawData = client.query("select items.id as 'no_item_id', items.name as 'nama_item', items.price, categories.name as 'nama_category', categories.id as 'category_id' from items 
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      order by items.id
      ")
    items = Array.new
    rawData.each do |data|
      category = Category.new(data["category_id"],data["nama_category"])
      item_data = Items.new(data["no_item_id"],data["nama_item"],data["price"],category)
      items.push(item_data)
    end
     items
  end
  
  def insert_item()
    client = create_db_client
    client.query("INSERT INTO items (id,name,price) VALUES (#{@id},'#{@name}',#{@price})")
    id = client.last_id
    id
  end
  
  
  def update_item(id)
    client = create_db_client
    client.query("UPDATE items set name = '#{@name}', price = #{@price} where id = #{id}")
  end
  
  def self.delete_item(id)
    client = create_db_client
    client.query("DELETE FROM items WHERE id = #{id}")
  end
end

