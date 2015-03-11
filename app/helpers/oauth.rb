INSTAGRAM_AUTH_URL = 'https://api.instagram.com/oauth/authorize/?client_id=accfee2f1a6d44259c4fb9f3ec73ecd0&redirect_uri=http://127.0.0.1:9393/authresponse_type=code'

# would prefer to be redirecting through saving the URL as a variable...

helpers do

  def log_user_in
    redirect INSTAGRAM_AUTH_URL
  end

end

