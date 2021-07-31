require_relative '../../controllers/itemController'
require_relative "../../models/items"
require_relative "../../models/itemCategories"

describe ItemController do
  # describe "create" do
  #   it "Should render createCategories.erb" do
      
  #   category = double()
  #   categories = [category]
    
  #   allow(category).to receive(:get_all_categories).and_return(categories)
  #   allow(category).to receive(:id).and_return(1)
  #   allow(category).to receive(:name).and_return("Main Dish")

  #   allow(ItemController).to receive(:new).and_return(category)

  #   controllers = ItemController.new

  #   response  = controllers.create
  #   expected_view = ERB.new(File.read("./views/create.erb"))
  #   expect(response).to eq expected_view.result(binding)
  #   end
  # end

  # describe "edit" do
  #   it "Should render " do
      
  #   category = double()
  #   categories = [category]
    
  #   allow(category).to receive(:get_all_categories).and_return(categories)
  #   allow(category).to receive(:id).and_return(1)
  #   allow(category).to receive(:name).and_return("Main Dish")

  #   allow(ItemController).to receive(:new).and_return(category)

  #   controllers = ItemController.new

  #   response  = controllers.create
  #   expected_view = ERB.new(File.read("./views/create.erb"))
  #   expect(response).to eq expected_view.result(binding)
  #   end
  # end

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

  # describe "find_item_detail" do
  #   it "Should render show_detail.erb" do
  #     item = double()
  #     items = [item]
  #     category = double()
  #     allow(item).to receive(:id).and_return(1)
  #     allow(item).to receive(:name).and_return("Makanan")
  #     allow(item).to receive(:price).and_return(5000)
  #     allow(category).to receive(:name).and_return("Desert")
  #     allow(item).to receive(:category).and_return(category)
  #     allow(Items).to receive(:update_category).and_return(items)
  #     response = ItemController.new
  #     expected_view = ERB.new(File.read("./views/items_with_categories.erb"))
  #     expect(response.show_all_items_with_category).to eq expected_view.result_with_hash(items: items)
  #   end
  # end

end