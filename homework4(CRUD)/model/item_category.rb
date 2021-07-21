require_relative './db_connector'

def delete_item_categories(id)
  client = create_db_client
  client.query("DELETE FROM item_categories WHERE item_id = #{id}")
end

def update_categories(id,category)
  client = create_db_client
  client.query("UPDATE item_categories set category_id = #{category} where item_id = #{id}")
end


def insert_categories(id,category)
  client = create_db_client
  client.query("INSERT INTO item_categories (item_id,category_id) VALUES ('#{id}',#{category})")
end