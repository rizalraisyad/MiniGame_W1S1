require_relative "../models/categories"

class CategoryController
  def create
    renderer = ERB.new(File.read("./views/createCategories.erb"))
    renderer.result(binding)
  end

  def insert(params)
    newId = Category.next_id
    categories = Category.new(newId, params['name'])
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
    category = Category.find_category(params['id']).each
    renderer = ERB.new(File.read("./views/editCategory.erb"))
    renderer.result(binding)
  end
  
  def delete(params)
    find_category = Category.find_category(params['id']).each
    category = Category.new(find_category[0]["id"],find_category[0]["name"])
    item_categories = Item_categories.find_all_items(params)
    item_categories.each do |item|
      item_category = Item_categories.new(item['item_id'],find_category[0]["id"])
      item_category.delete_categories
    end
    category.delete
  end

  def update(params)
    category = Category.new(params['id'],params['name'])
    category.update
  end
end