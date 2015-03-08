get '/' do
  user = User.new
  erb :index, locals: { user: user }
end

