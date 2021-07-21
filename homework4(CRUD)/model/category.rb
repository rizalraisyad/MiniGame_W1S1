require_relative './db_connector'

class Category
  attr_reader :id, :name
  def initialize(id, name)
    @id = id
    @name =  name
  end
end

def get_all_categories
  client = create_db_client
  rawData = client.query("select * from categories")
  items = Array.new
  rawData.each do |data|
    category = Category.new(data["id"],data["name"])
    items.push(category)
  end
  items
end