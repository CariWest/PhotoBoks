INSTAGRAM_AUTH_URL = 'https://api.instagram.com/oauth/authorize/?client_id=accfee2f1a6d44259c4fb9f3ec73ecd0&redirect_uri=http://127.0.0.1:9393/authresponse_type=code'

# would prefer to be redirecting through saving the URL as a variable...

helpers do

  def get_user(username)
    return User.find_by(username: username)
  end

  def create_user(user_data, access_token)
    return User.create!(
      username: user_data["username"],
      full_name: user_data["full_name"],
      bio: user_data["bio"],
      website: user_data["website"],
      profile_picture: user_data["profile_picture"],
      instagram_id: user_data["id"],
      access_token: access_token
    )
  end

  def get_user_token(user_id)
    user = User.find(user_id)
    return user.access_token
  end

end

