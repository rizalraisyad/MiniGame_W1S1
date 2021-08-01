require_relative '../../controllers/categoryController'


describe CategoryController do
  describe "create" do
    it "Should render createCategories.erb" do
      controllers = CategoryController.new
      response  = controllers.create
      expected_view = ERB.new(File.read("./views/createCategories.erb"))
      expect(response).to eq(expected_view.result)
    end
  end

  describe "insert" do
    it "Should save new data" do
      categories = double()
      allow(Category).to receive(:new).and_return(categories)
      allow(categories).to receive(:save)
      controllers = CategoryController.new
      controllers.insert({
        "name"=> "dish"
      })
    end
  end

  describe "show_all_category" do
    it "Should print views categories" do
      c = double()
      allow(c).to receive(:id).and_return(5)
      allow(c).to receive(:name).and_return("Makanan")
      category = [c]
      allow(Category).to receive(:get_all_categories).and_return(category)
      expected_view = ERB.new(File.read("./views/categories.erb"))
      controllers = CategoryController.new
      response = controllers.show_all_category
      expect(response).to eq expected_view.result(binding)
    end
  end

  describe "show_all_categories_with_items" do
    it "Should print views categories" do
      c = double()
      allow(c).to receive(:name).and_return("Makanan")
      allow(c).to receive(:items).and_return("A, b, c")
      category = [c]
      allow(Category).to receive(:all_categories_with_items).and_return(category)


      expected_view = ERB.new(File.read("./views/categories_with_items.erb"))
      controllers = CategoryController.new
      response = controllers.show_all_categories_with_items
      expect(response).to eq expected_view.result(binding)
    end
  end

  describe "edit" do
    it "Should print views edit" do
      
      allow(Category).to receive(:find_category).and_return([{
        "id"=> 5,
        "name"=> "makanan"
      }])

      category = {
        "id"=> 5,
        "name"=> "makanan"
      }
      expected_view = ERB.new(File.read("./views/editCategory.erb"))
      controllers = CategoryController.new
      response = controllers.edit({
        "id"=>5
      })
      expect(response).to eq expected_view.result(binding)
    end
  end


  describe "delete" do
    it "Should ex delete" do    

      allow(Category).to receive(:find_category).and_return([{
        "id" => 1,
        "name" => "makanan"
      }])
      find_category = {
        "id"=> 1,
        "name"=> "makanan"
      }
      
      category = double()
      allow(Category).to receive(:new).and_return(category)
      allow(category).to receive(:delete)

      categoryitem = {
        "item_id"=>5
      }
      item_categories = [categoryitem]
      allow(Item_categories).to receive(:find_all_items).and_return(item_categories)
      
      item_category = double()
      allow(Item_categories).to receive(:new).and_return(item_category)      
      allow(item_category).to receive(:delete_categories) 
      

      controllers = CategoryController.new
      response = controllers.delete({
        "id"=> 5
      })
    end
  end

  describe "update" do
    it "Should ex update" do
      category = double()
      allow(Category).to receive(:new).and_return(category)
      allow(category).to receive(:update)

      controllers = CategoryController.new
      controllers.update({
        "id"=> 5,
        "name"=> "Makanan"
      })
    end
  end
end