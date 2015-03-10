helpers do

  def create_tag(tag_name)
    Tag.create(tag: tag_name) unless tag_exists?
  end

  def tag_exists?(tag_name)
    Tag.where(tag: tag_name).first ? true : false
  end

end