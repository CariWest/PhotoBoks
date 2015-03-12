get '/' do
  albums = Album.all.sort_by { |album| album.updated_at }.reverse
  erb :index, locals: { albums: albums }
end

