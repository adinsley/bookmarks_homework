get '/bookmarks' do  
  @bookmarks = Bookmark.all
  erb :'/bookmarks/index'
end

get '/bookmarks/new' do
  @bookmark = Bookmark.new
  erb :'bookmarks/new'
end

post '/bookmarks' do
  @bookmark = Bookmark.new(params[:bookmark])
  @bookmark.save
  redirect to('bookmarks')
end

get '/bookmarks/:id/edit' do
  @bookmark = Bookmark.find(params[:id])
  erb :'bookmarks/edit'
end

post '/bookmarks/:id' do
@bookmark = Bookmark.find(params[:id])
@bookmark.update_attributes(params[:bookmark])
redirect to('/bookmarks')
end

post '/bookmarks/:id/delete' do
bookmark = Bookmark.find(params[:id])
bookmark.destroy
redirect to('/bookmarks')
end

get '/bookmarks/search' do
erb :'bookmarks/search'
end

get '/bookmarks/searched' do
  sql = "SELECT * FROM bookmarks WHERE name like '%#{params[:search]}%' or url like '%#{params[:search]}%'"
  
  @bookmarks = run_sql(sql)
  
  erb :'bookmarks/result'

end




def run_sql(sql)
  conn = PG.connect(dbname: 'bookmarks', host: 'localhost')

  result = conn.exec(sql)
  conn.close
  result
end

