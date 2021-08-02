require_relative '../../models/items'

describe Items do
  describe "insert_item" do
    it "Should execute the queries" do
      items = Items.new(1,"Nasi Goreng",5000)
      query = "INSERT INTO items (name,price) VALUES ('#{items.name}',#{items.price})"
      client = double

      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      # expect(client).to receive(:query).with(query)
      
      new_item_id = 1
      
      expect(client).to receive(:last_id).and_return(new_item_id)
      items.insert_item
      
    end
  end

  describe "set_name" do
    it "Should change name " do
      item = Items.new(1, "Test", 5000)
      item.set_name("hello")
      expect(item.name).to eq("hello")
    end
  end

  describe "set_price" do
    it "Should change price " do
      item = Items.new(1, "Test", 5000)
      item.set_price(1000)
      expect(item.price).to eq(1000)
    end
  end

  describe "set_category" do
    it "Should change category " do
      item = Items.new(1, "Test", 5000, nil)
      category = double()
      item.set_category(category)
      expect(item.category).to eq(category)
    end
  end

  describe "update" do
    it "Should execute the queries" do
      items = Items.new(1,"Nasi Goreng",5000)
      query = "UPDATE items set name = '#{items.name}', price = #{items.price} where id = #{items.id}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      items.update
    end
  end

  describe "delete" do
    it "Should execute the queries" do
      items = Items.new(1,"Nasi Goreng",5000)
      query = "DELETE FROM items WHERE id = #{items.id}"
      client = double
      expect(client).to receive(:query).with(query)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      items.delete
    end
  end

  describe "valid?" do
    it "return true" do
      items = Items.new(1,"Nasi Goreng",5000)
      expect(items.valid?).to be true
    end
    it "return false cause name.nil" do
      items = Items.new(1,"Nasi Goreng",nil)
      expect(items.valid?).to be false
    end
    it "return false cause id.nil" do
      items = Items.new(1,nil,5000)
      expect(items.valid?).to be false
    end
  end

  describe "get_item_detail" do
    it "Should execute the queries" do
      rawData = [{
        "category_id"=> 1,
        "nama_category"=> "dish",
        "items_name"=> "makanan",
        "price"=> 5000
      }]
      client = double()
      id = 1
      query1 = "select items.id as 'id', items.name as 'items_name', items.price, item_categories.category_id, categories.name as 'nama_category' from items
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      where items.id = #{id}
      " 
      expect(client).to receive(:query).with(query1).and_return(rawData)
      allow(Mysql2::Client).to receive(:new).and_return(client)
      
      items = Items.new(1,"Nasi goreng",5000)   
      items.get_item_detail
    end
  end

  describe "update_category" do
    it "Should execute the queries" do
      category = double()
      items = Items.new(1,"Nasi Goreng",5000,category)
      query = "select items.id as 'id', items.name as 'items_name', items.price, item_categories.category_id, categories.name as 'nama_category' from items
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      where items.id = #{items.id}
      "
      client = double
      expect(client).to receive(:query).with(query).and_return([{
        "category_id"=> 1,
        "nama_category"=> "Nasi Goreng"
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      items.update_category

      
      allow(Category).to receive(:new).and_return(category)
      items.category
    end
  end

  describe "self_find_item" do
    it "Should execute the queries" do
      id = 5
      query = "SELECT * FROM items where id = #{id}"
      client = double
      expect(client).to receive(:query).with(query).and_return([{
        "id"=>5,
        "name"=>"Makanan",
        "price"=>5000,
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Items::self_find_item({
        "id"=>5
      })
    end
  end

  describe "get_items" do
    it "Should execute the queries" do
      query = "select * from items"
      client = double
      expect(client).to receive(:query).with(query).and_return([{
        "id"=> 1,
        "name"=> "name",
        "price"=> 5000
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Items::get_items
    end
  end

  describe "get_items_with_categories" do
    it "Should execute the queries" do
      query = "select items.id as 'no_item_id', items.name as 'nama_item', items.price, categories.name as 'nama_category', categories.id as 'category_id' from items 
      join item_categories on items.id = item_categories.item_id
      join categories on item_categories.category_id = categories.id
      order by items.id
      "
      client = double
      expect(client).to receive(:query).with(query).and_return([{
        "category_id"=> 1,
        "nama_category"=> "nama",
        "no_item_id"=> 1,
        "nama_item"=> "nama_item",
        "price"=> 5000
      }])
      allow(Mysql2::Client).to receive(:new).and_return(client)
      Items::get_items_with_categories
    end
  end
end