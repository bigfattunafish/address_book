require 'pg'
require 'pry'
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?

# db = PG.connect(:dbname => 'address_book',
#   :host => 'localhost')
# sql = "select * from contacts"
# db.exec(sql) do |result|
#   result.each do |row|
#     puts row
#   end
# end
# db.close


# METHOD TO ACCESS DATA BASE
def access_db
  db = PG.connect(
    :dbname => 'address_book',
    :host => 'localhost')
  return db
end

get '/' do
  @db_accessed = access_db
  erb :getdata
end

post '/' do
  @first = params[:first].chomp.capitalize
  @last = params[:last].chomp.capitalize
  @age = params[:age].chomp.to_i
  @gender = params[:gender].chomp.upcase
  @dtgd = params[:dtgd].chomp
  @phone = params[:phone].chomp

  @db_accessed = access_db
  sql_input = "INSERT INTO contacts (first, last, age, gender, dtgd, phone) VALUES ('#{@first}', '#{@last}', '#{@age}', '#{@gender}', '#{@dtgd}', '#{@number}')"
  @db_accessed.exec(sql_input)
  @db_accessed.close

  redirect to("/thanks")
end

get '/thanks' do
  erb :thankyou
end



