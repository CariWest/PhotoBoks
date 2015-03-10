get '/albums' do
end

get '/albums/new' do
  form = erb :"albums/new", layout: false
  content_type :json
  { form: form }.to_json
end

post '/albums' do
  puts "inside new album post method!"
end

put '/album/:id' do
end

delete '/album/:id' do
end

