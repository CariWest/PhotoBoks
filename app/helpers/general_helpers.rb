helpers do
  def get_current_user(id)
    return User.find(id)
  end

  def find_or_create_tag(tag_name)
    return if Tag.find_by(name: tag_name)
    Tag.create!(name: tag_name)
  end
end
