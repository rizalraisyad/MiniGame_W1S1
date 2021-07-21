require 'sinatra'
require_relative './model/items'
require_relative './model/category'
require_relative './model/item_category'

get '/' do
  items = get_all_items_with_categories
  erb :index, locals:{
    items: items
  }
end

get '/items/new' do
  category = get_all_categories
  erb :create, locals:{
    category: category
  }
end

post '/items/create' do
  name = params['name']
  price = params['price']
  category = params['category']
  id = insert_item(name,price,category)
  insert_categories(id,category)
  redirect  '/'
end

get '/items/detail/:id' do
  id = params['id']
  detail = item(id)
  erb :detail, locals:{
    detail: detail
  }
end

get '/items/edit/:id' do
  id = params['id']
  detail = item(id)
  category = get_all_categories
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
  update_item(id,name,price)
  update_categories(id,category)
  redirect  '/'
end

delete '/item/:id' do
  id = params['id']
  delete_item_categories(id)
  delete_item(id)
  redirect  '/'
end