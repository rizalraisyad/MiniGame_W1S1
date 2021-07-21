require 'mysql2'
def create_db_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => "admin",
    :password => "qwerty",
    :database => "food_oms_db"
  )
  client
end