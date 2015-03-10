helpers do

  def get_tag(tag_name)
    tag =Tag.where(name: tag_name).first
    if tag
      return tag
    else
      return Tag.create(name: tag_name)
    end
  end

  def get_current_user(id)
    return User.find(id)
  end

end