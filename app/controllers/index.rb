get '/' do
  albums = Album.all
  erb :index, locals: { albums: albums }
end

