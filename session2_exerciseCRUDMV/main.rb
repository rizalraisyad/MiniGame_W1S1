require 'sinatra'
require_relative './models/items/items'
require_relative './models/categories/category'
require_relative './models/item_categories/item_categories'

get '/' do
  items = Items.get_all_items_with_categories
  erb :index, locals:{
    items: items
  }
end

get '/items/new' do
  category = Category.get_all_categories
  erb :create, locals:{
    category: category
  }
end

post '/items/create' do
  name = params['name']
  price = params['price']
  category = params['category']
  last_id = 0
  Items.next_id.each do |id|
    last_id = id["MAX(Id)"]
  end
  item = Items.new(last_id+1,name,price)
  id = item.insert_item
  categories = Item_categories.new(id,category)
  categories.insert_categories
  redirect  '/'
end

get '/items/detail/:id' do
  id = params['id']
  detail = Items.item(id)
  erb :detail, locals:{
    detail: detail
  }
end

get '/items/edit/:id' do
  id = params['id']
  detail = Items.item(id)
  category = Category.get_all_categories
  erb :edit, locals:{
    detail: detail,
    category: category
  }
end

put '/item/:id' do
  id = params['id']
  name = params['name']
  price = params['price']
  category = params['category']
  item = Items.new(id,name,price)
  item.update_item(id)
  item_categories = Item_categories.new(id,category)
  item_categories.update_categories
  redirect  '/'
end

delete '/item/:id' do
  id = params['id']
  Item_categories.delete_item_categories(id)
  Items.delete_item(id)
  redirect  '/'
end