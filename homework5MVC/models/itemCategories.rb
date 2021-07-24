require_relative '../db/db_connector'


 class Item_categories
  attr_reader :id_items, :id_category

  def initialize(id_items,id_category) 
    @id_items = id_items
    @id_category = id_category
  end

  def set_categories(id_category)
    @id_category = id_category
  end

  def delete_item_category
    client = create_db_client
    client.query("DELETE FROM item_categories WHERE item_id = #{@id_items}")
  end

  def delete_categories
    client = create_db_client
    client.query("DELETE FROM item_categories WHERE category_id = #{@id_category}")
  end
  
  def update
    return false unless valid?
    client = create_db_client
    client.query("UPDATE item_categories set category_id = #{@id_category} where item_id = #{@id_items}")
  end
  
  def insert
    return false unless valid?
    client = create_db_client
    client.query("INSERT INTO item_categories (item_id,category_id) VALUES ('#{@id_items}',#{@id_category})")
  end

  def valid?
    return false if @id_items.nil?
    return false if @id_category.nil?
    true
  end

  def self.find_item(params)
    client = create_db_client
    client.query("select * from item_categories where item_id = #{params['id']}")
  end

  def self.find_all_items(params)
    client = create_db_client
    client.query("select * from item_categories where category_id = #{params['id']}")
  end
end

