require_relative '../../db/mysql_connector'


 class Item_categories
  attr_accessor :id_items, :id_category

  def initialize(id_items,id_category) 
    @id_items = id_items
    @id_category = id_category
  end

  def self.delete_item_categories(id)
    client = create_db_client
    client.query("DELETE FROM item_categories WHERE item_id = #{id}")
  end
  
  def update_categories()
    client = create_db_client
    client.query("UPDATE item_categories set category_id = #{@id_category} where item_id = #{@id_items}")
  end
  
  
  def insert_categories()
    client = create_db_client
    client.query("INSERT INTO item_categories (item_id,category_id) VALUES ('#{@id_items}',#{@id_category})")
  end
end

