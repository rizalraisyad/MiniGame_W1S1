require_relative '../../models/itemCategories'

describe Item_categories do
  describe "delete_item_category" do
    it "Should execute the queries" do
      item_categories = Item_categories.new(1,2)
      query = "DELETE FROM item_categories WHERE item_id = #{item_categories.id_items}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      item_categories.delete_item_category
    end
  end

  describe "set_categories" do
    it "Should change IdCategories" do
      item_categories = Item_categories.new(1,2)
      item_categories.set_categories(1)
      expect(item_categories.id_category).to eq(1)
    end
  end

  describe "delete_categories" do
    it "Should delete_categories" do
      item_categories = Item_categories.new(1,2)
      query = "DELETE FROM item_categories WHERE category_id = #{item_categories.id_category}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      item_categories.delete_categories
    end
  end

  describe "update" do
    it "Should execute the queries" do
      item_categories = Item_categories.new(1,2)
      query = "UPDATE item_categories set category_id = #{item_categories.id_category} where item_id = #{item_categories.id_items}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      item_categories.update
    end
  end

  describe "insert" do
    it "Should execute the queries" do
      item_categories = Item_categories.new(1,2)
      query = "INSERT INTO item_categories (item_id,category_id) VALUES ('#{item_categories.id_items}',#{item_categories.id_category})"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      item_categories.insert
    end
  end

  describe "valid?" do
    it "return true" do
      item_categories = Item_categories.new(1,1)
      expect(item_categories.valid?).to be true
    end
    it "return false cause name.nil" do
      item_categories = Item_categories.new(1,nil)
      expect(item_categories.valid?).to be false
    end
    it "return false cause id.nil" do
      item_categories = Item_categories.new(nil,1)
      expect(item_categories.valid?).to be false
    end
  end

  describe "find_item" do
    it "should execute query" do
      params = 5
      query = "select * from item_categories where item_id = #{params}"
      client = double
      
      expect(client).to receive(:query).with(query).and_return([{
        "item_id" =>5,
        "category_id"=>5
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      Item_categories::find_item({
        "id"=>5
      })
    end
  end

  describe "find_all_items" do
    it "Should execute the queries" do
      item_categories = Item_categories.new(1,2)
      params = 5
      query = "select * from item_categories where category_id = #{params}"
      client = double
      expect(client).to receive(:query).with(query).and_return([{
        "item_id" =>5,
        "category_id"=>5
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Item_categories::find_all_items({
        "id"=>5
      })
    end
  end
end