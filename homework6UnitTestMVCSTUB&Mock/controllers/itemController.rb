require_relative "../models/items"
require_relative "../models/itemCategories"

class ItemController
  def create
    category = Category.get_all_categories
    renderer = ERB.new(File.read("./views/create.erb"))
    renderer.result(binding)
  end

  def insert(params)
    categories = Category.find_category(params['category'])
    newId = Items.next_id
    item = Items.new(newId,params['name'],params['price'],categories)
    item.insert_item
    item_categories = Item_categories.new(newId,params['category'])
    item_categories.insert
  end

  def show_all_items
    items = Items.get_items
    renderer = ERB.new(File.read("./views/items.erb"))
    renderer.result(binding)
  end

  def show_all_items_with_category
    items = Items.get_items_with_categories
    renderer = ERB.new(File.read("./views/items_with_categories.erb"))
    renderer.result(binding)
  end

  def find_item_detail(params)
    item = Items.self_find_item(params).each
    item_detail = Items.new(item[0]["id"],item[0]["name"],item[0]["price"])
    item_detail.update_category
    renderer = ERB.new(File.read("./views/show_detail.erb"))
    renderer.result(binding)
  end
 
  def edit(params)
    item = Items.self_find_item(params).each
    item_detail = Items.new(item[0]["id"],item[0]["name"],item[0]["price"])
    item_detail.update_category
    category = Category.get_all_categories
    renderer = ERB.new(File.read("./views/edit.erb"))
    renderer.result(binding)
  end

  def update(params)
    categories = Category.find_category(params['category'])
    item = Items.new(params['id'],params['name'],params['price'],categories)
    item.update
    item_categories = Item_categories.new(params['id'],params['category'])
    item_categories.update
  end

  def delete(params)
    find_item = Items.self_find_item(params).each
    item = Items.new(params['id'],find_item[0]['name'],find_item[0]['price'])
    item_categories = Item_categories.find_item(params).each
    item_category = Item_categories.new(item.id,item_categories[0]['id_category'])
    item_category.delete_item_category
    item.delete
  end
end