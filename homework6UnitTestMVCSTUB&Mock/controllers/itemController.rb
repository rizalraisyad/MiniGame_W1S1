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
    item = Items.new(nil,params['name'],params['price'],categories)
    item.insert_item

    item_categories = Item_categories.new(item.id,params['category'])
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
    items = Items.self_find_item(params)
    item = nil
    items.each do |itemdetail|
      item = {
        "id" => itemdetail["id"],
        "name" => itemdetail["name"],
        "price" => itemdetail["price"]
      }
      break;
    end
    item_detail = Items.new(item["id"],item["name"],item["price"])
    item_detail.update_category
    renderer = ERB.new(File.read("./views/show_detail.erb"))
    renderer.result(binding)
  end
 
  def edit(params)
    rawdata = Items.self_find_item(params) 
    item = nil
    rawdata.each do |data|
      item = {
        "id" => data["id"],
        "name" => data["name"],
        "price" => data["price"]
      }
      break;
    end
    item_detail = Items.new(item["id"],item["name"],item["price"])
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
    data = Items.self_find_item(params)
    find_item = nil
    data.each do |node|
      find_item = {
        "name" => node["name"],
        "price" => node["price"]
      }
      break;
    end

    item = Items.new(params['id'],find_item['name'],find_item['price'])
    item_categoryRaw = Item_categories.find_item(params)
    item_categories = nil
    item_categoryRaw.each do |item|
      item_categories = {
        "id_category" => item["id_category"]
      }
      break;
    end
    item_category = Item_categories.new(item.id,item_categories['id_category'])
    item_category.delete_item_category
    item.delete
  end
end