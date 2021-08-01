require_relative '../db/db_connector'

class Category
  attr_reader :id, :name, :items
  
  def initialize(id, name, items=nil)
    @id = id
    @name =  name
    @items = items
  end

  def setname(params)
    @name =  params['name']
  end

  def update
    return false unless valid?
    client = create_db_client
    client.query("UPDATE categories set name = '#{@name}' where id = #{@id}")
  end

  def save
    return false unless valid?
    client = create_db_client
    client.query("INSERT INTO categories (name) VALUES ('#{@name}')")
  end

  def valid?
    return false if @name.nil?
    true
  end

  def delete
    client = create_db_client
    client.query("DELETE FROM categories WHERE id = #{@id}")
  end

  def self.get_all_categories
    client = create_db_client
    rawData = client.query("select * from categories order by id")
    items = Array.new
    rawData.each do |data|
      category = Category.new(data["id"],data["name"])
      items.push(category)
    end
    items
  end

  def self.all_categories_with_items
    client = create_db_client
    rawData = client.query("select group_concat(DISTINCT categories.id) as id , group_concat(DISTINCT categories.name) as category, group_concat(items.name) as items from categories join item_categories on categories.id = item_categories.category_id join items on item_categories.item_id = items.id group by categories.name order by id")
    items = Array.new
    rawData.each do |data|
      category = Category.new(data["id"],data["category"],data["items"])
      items.push(category)
    end
    items
  end

  def self.find_category(params) 
    client = create_db_client
    category = client.query("select * from categories where id = #{params}")
  end
end

