require 'sinatra'
require_relative "./controllers/categoryController"
require_relative "./controllers/itemController"

get '/' do
  controllers = ItemController.new
  controllers.show_all_items_with_category
end

get '/items' do
  controllers = ItemController.new
  controllers.show_all_items
end

get '/items/:id' do
  controllers = ItemController.new
  controllers.find_item_detail(params)
end

get '/items/edit/:id' do
  controllers = ItemController.new
  controllers.edit(params)
end

put '/item/:id' do
  controllers = ItemController.new
  controllers.update(params)
  redirect '/'
end

delete '/item/:id' do
  controllers = ItemController.new
  controllers.delete(params)
  redirect '/'
end

post '/item/' do
  controllers = ItemController.new
  controllers.insert(params)
  redirect '/'
end

get '/item/new' do
  controllers = ItemController.new
  controllers.create
end

##

get '/category' do
  controllers = CategoryController.new
  controllers.show_all_category
end

get '/category/new' do
  controllers = CategoryController.new
  controllers.create
end

post '/category/' do
  controllers = CategoryController.new
  controllers.insert(params)
  redirect '/category'
end

get '/category/edit/:id' do
  controllers = CategoryController.new
  controllers.edit(params)
end

put '/category/:id' do
  controllers = CategoryController.new
  controllers.update(params)
  redirect '/category'
end

get '/category/items' do
  controllers = CategoryController.new
  controllers.show_all_categories_with_items
end

delete '/category/:id' do
  controllers = CategoryController.new
  controllers.delete(params)
  redirect '/category'
end