helpers do
  def get_current_user(id)
    return User.find(id)
  end

  # this method is so ugly. Refactor me eventually!
  def find_or_create_tag(tag_name)
    if Tag.find_by(name: tag_name)
      @tag = Tag.find_by(name: tag_name)
    else
      @tag = Tag.create!(name: tag_name)
    end
    return @tag
  end
end

