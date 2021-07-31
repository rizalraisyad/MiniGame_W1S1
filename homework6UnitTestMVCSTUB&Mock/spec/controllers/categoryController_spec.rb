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

  # describe "insert" do
  #   it "Should save new data" do
  #     controllers = CategoryController.new

  #   end
  # end

  # describe "show_all_category" do
  #   it "Should print views categories" do
  #     response  = controllers.show_all_category

  #     item = double()
  #     items = [item]

  #     allow(item).to receive(:id).and_return(1)
  #     allow(item).to receive(:name).and_return("Makanan")

  #     allow(Category).to receive(:new).and_return(item)
  #     expected_view = ERB.new(File.read("./views/categories.erb"))
  #     expect(response).to eq(expected_view.result)

  #     controllers = CategoryController.new
  #     controllers = CategoryController.show_all_category

  #   end
  # end

  # describe "delete" do
  #   it "Should render createCategories.erb" do
  #     controllers = CategoryController.new
      
  #     params = [{
  #       id: 1,
  #       name: "Rizal"
  #     }]
      
  #     category = double()
  #     allow(category).to receive(:new).with(params)
  #     controllers.update(params)
  #     expect(category).to receive(:update).with(params)
  #   end
  # end
end