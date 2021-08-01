require_relative '../../controllers/itemController'

describe ItemController do
  describe "create" do
    it "Should render createCategories.erb" do
      
    c = double()
    category = [c]
    
    allow(c).to receive(:id).and_return(nil)
    allow(c).to receive(:name).and_return("Main Dish")
    allow(Category).to receive(:get_all_categories).and_return(category)

    controllers = ItemController.new

    response  = controllers.create
    expected_view = ERB.new(File.read("./views/create.erb"))
    expect(response).to eq expected_view.result(binding)
    end
  end

  describe "show_all_items" do
    it "Should render items.erb" do
      item = double()
      items = [item]
      allow(item).to receive(:id).and_return(1)
      allow(item).to receive(:name).and_return("Makanan")
      allow(item).to receive(:price).and_return(5000)
      allow(Items).to receive(:get_items).and_return(items)
      response = ItemController.new
      expected_view = ERB.new(File.read("./views/items.erb"))
      expect(response.show_all_items).to eq expected_view.result_with_hash(items: items)
    end
  end

  describe "show_all_items_with_category" do
    it "Should render items_with_categories.erb" do
      item = double()
      items = [item]
      category = double()
      allow(item).to receive(:id).and_return(1)
      allow(item).to receive(:name).and_return("Makanan")
      allow(item).to receive(:price).and_return(5000)
      allow(category).to receive(:name).and_return("Desert")
      allow(item).to receive(:category).and_return(category)
      allow(Items).to receive(:get_items_with_categories).and_return(items)
      response = ItemController.new
      expected_view = ERB.new(File.read("./views/items_with_categories.erb"))
      expect(response.show_all_items_with_category).to eq expected_view.result_with_hash(items: items)
    end
  end

  describe "insert" do
    it "Should execute insert item and itemcategories" do
      category = double()
      categories = [category]
      item = double()
      allow(Items).to receive(:new).and_return(item)
      allow(item).to receive(:insert_item)
      allow(item).to receive(:id).and_return(5)
      allow(Category).to receive(:find_category).and_return(categories)

      item_categories = double()
      allow(Item_categories).to receive(:new).and_return(item_categories)
      allow(item_categories).to receive(:insert)
      
      response = ItemController.new
      response.insert({'category'=>5})
    end
  end
  
  describe "edit" do
    it "Should render edit" do
      params = {
        "id" => 5
      }
      category_item = double()
      category = [category_item]
      allow(category_item).to receive(:id).and_return(1)
      allow(category_item).to receive(:name).and_return("Cake")

      item_detail = double()
      allow(item_detail).to receive(:update_category)
      allow(item_detail).to receive(:name).and_return("Makanan")
      allow(item_detail).to receive(:id).and_return(5)
      allow(item_detail).to receive(:price).and_return(5000)
      allow(item_detail).to receive(:category).and_return(category_item)

      allow(Items).to receive(:self_find_item).and_return([{
        "id" => 5,
        "name" => "makanan",
        "price" => 5555
      }])
      allow(Items).to receive(:new).and_return(item_detail)

      allow(Category).to receive(:get_all_categories).and_return(category)

      controllers = ItemController.new
      response  = controllers.edit(params)
      expected_view = ERB.new(File.read("./views/edit.erb"))
      expect(response).to eq expected_view.result(binding)

    end
  end
  describe "find_item_detail" do
    it "Should render show_detail.erb" do

      allow(Items).to receive(:self_find_item).and_return([{
        "id" => 5,
        "name" => "makanan",
        "price" => 5555
      }])

      category = double()
      allow(category).to receive(:name).and_return("main dish")

      item_detail = double()
      allow(Items).to receive(:new).and_return(item_detail)
      allow(item_detail).to receive(:update_category)
      allow(item_detail).to receive(:name).and_return("makanan")
      allow(item_detail).to receive(:price).and_return(5000)
      allow(item_detail).to receive(:category).and_return(category)

      controllers = ItemController.new
      params = {
        "id" => 5
      }
      response = controllers.find_item_detail(params)
      expected_view = ERB.new(File.read("./views/show_detail.erb"))
      expect(response).to eq expected_view.result(binding)
    end
  end


  describe "update" do
    it "Should render show_detail.erb" do
      category = double()
      categories = [category]
      allow(Category).to receive(:find_category).and_return(categories)

      item = double()
      allow(Items).to receive(:new).and_return(item)
      allow(item).to receive(:update)
      item_categories = double()
      allow(Item_categories).to receive(:new).and_return(item_categories)
      allow(item_categories).to receive(:update)

      controller = ItemController.new
      controller.update({
        "category"=>5,
        "id"=>5,
        "name"=>"makanan",
        "price"=>500
      })
    end
  end

  describe "delete" do
    it "Should render show_detail.erb" do
      allow(Items).to receive(:self_find_item).and_return([{
        "name"=> "makanan",
        "price"=> 5000
      }])

      item = double()
      allow(Items).to receive(:new).and_return(item)
      allow(item).to receive(:id).and_return(5)
      allow(Item_categories).to receive(:find_item).and_return([{
        "id_category"=> 5
      }])

      item_category = double()
      allow(Item_categories).to receive(:new).and_return(item_category)
      allow(item_category).to receive(:delete_item_category)
      allow(item).to receive(:delete)

      controller = ItemController.new
      controller.delete({
        "id"=>5
      })
    end
  end
end