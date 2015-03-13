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
    user = get_current_user
    return user.access_token
  end

  def get_current_user
    return User.find(session[:id])
  end
end

