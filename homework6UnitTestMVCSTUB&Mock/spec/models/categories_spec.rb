require_relative '../../models/categories'

describe Category do
  describe "update" do
    it "Should execute the queries" do
      category = Category.new(1,"makanan")
      query = "UPDATE categories set name = '#{category.name}' where id = #{category.id}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      category.update
    end
  end

  describe "setname" do
    it "Should change name" do
      category = Category.new(1,"makanan")
      category.setname({
        "name"=> "Baso"
      })
      expect(category.name).to eq("Baso")
    end
  end

  describe "save" do
    it "Should execute the queries" do
      category = Category.new(nil,"makanan")
      query = "INSERT INTO categories (name) VALUES ('#{category.name}')"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      category.save
    end
  end

  describe "valid?" do
    it "return true" do
      category = Category.new(1,"makanan")
      category.valid?
      expect(category.valid?).to be true
    end
    it "return false cause name.nil" do
      category = Category.new(1,nil)
      category.valid?
      expect(category.valid?).to be false
    end
  end

  describe "delete" do
    it "should execute query" do
      category = Category.new(1,"makanan")
      query = "DELETE FROM categories WHERE id = #{category.id}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      category.delete
    end
  end

  describe "get_all_categories" do
    it "should execute query" do
      query = "select * from categories order by id"
      client = double
      
      expect(client).to receive(:query).with(query).and_return([{
        "id"=> 1,
        "name"=> "Dish"
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Category::get_all_categories
    end
  end

  describe "all_categories_with_items" do
    it "should execute query" do
      query = "select group_concat(DISTINCT categories.id) as id , group_concat(DISTINCT categories.name) as category, group_concat(items.name) as items from categories join item_categories on categories.id = item_categories.category_id join items on item_categories.item_id = items.id group by categories.name order by id"

      client = double
      expect(client).to receive(:query).with(query).and_return([
        {
          "id" => 1,
          "category" => "Dessert",
          "items" => "Makanan"
        }
      ])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Category::all_categories_with_items
    end
  end

  describe "find_category" do
    it "should execute query" do
      params = 5
      query = "select * from categories where id = #{params}"
      client = double
      
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Category::find_category(5)
    end
  end
end