require 'sinatra'
require 'sequel'
require 'sqlite3'

DB = Sequel.connect('sqlite://Userrec.db')
DB2 = Sequel.connect('sqlite://Accounts.db')


set :views, 'views'

get '/' do
  erb :register
end

get '/cre' do
  DB.create_table :items do
    Title :title
    Link :link
    Creator :creator
    Class :class
    Descrip :descrip
  end
  redirect '/pro'
end

get '/cac' do
  DB2.create_table :items do
    Username :username
    Username :username
    Password :password
  end
  redirect '/'
end


get '/rec' do
  @items= DB[:post]
  title=params['title']
  link=params['link']
  creator=params['creator']
  clas=params['class']
  descrip=params['description']
  @items.insert(:title => title, :link => link, :creator => creator, :class => clas, :descrip => descrip)
  erb :reccomendations
end

get '/pro' do
  @items = DB[:userrec]
  @items.each do |x|
    puts x[:title]
    puts x[:link]
    puts x[:creator]
    puts x[:class]
    puts x[:descrip]

    end
  erb :profile
end

post "/login" do
@accounts = DB2[:accounts]
username = params['username']chomp
password = params['password']chomp

user = @accounts[username => username]
if username == nil
redirect "/"
elsif user [:password == password]
redirect "/pro"
else
redirect "/"
end
end

