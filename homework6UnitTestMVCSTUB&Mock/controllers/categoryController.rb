require_relative "../models/categories"

class CategoryController
  def create
    renderer = ERB.new(File.read("./views/createCategories.erb"))
    renderer.result(binding)
  end

  def insert(params)
    categories = Category.new(nil, params['name'])
    categories.save
  end


  def show_all_category
    category = Category.get_all_categories
    renderer = ERB.new(File.read("./views/categories.erb"))
    renderer.result(binding)
  end
  
  def show_all_categories_with_items
    category = Category.all_categories_with_items
    renderer = ERB.new(File.read("./views/categories_with_items.erb"))
    renderer.result(binding)
  end

  def edit(params)
    categories = Category.find_category(params['id'])
    category = nil
    categories.each do |item|
      category = {
        "id" => item["id"],
        "name" => item["name"]
      }
      break;
    end
    renderer = ERB.new(File.read("./views/editCategory.erb"))
    renderer.result(binding)
  end
  
  def delete(params)
    find_categories = Category.find_category(params['id'])
    find_category = nil
    find_categories.each do |item|
      find_category = {
        "id" => item["id"],
        "name" => item["name"]
      }
      break;
    end
    category = Category.new(find_category["id"],find_category["name"])

    item_categories = Item_categories.find_all_items(params)
    item_categories.each do |item|
      item_category = Item_categories.new(item['item_id'],find_category["id"])
      item_category.delete_categories
    end

    category.delete
  end

  def update(params)
    category = Category.new(params['id'],params['name'])
    category.update
  end
end