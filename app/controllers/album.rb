get '/albums' do
end

get '/albums/new' do
  form = erb :"albums/new", layout: false
  content_type :json
  { form: form }.to_json
end

post '/albums' do

end

put '/album/:id' do
end

delete '/album/:id' do
end

