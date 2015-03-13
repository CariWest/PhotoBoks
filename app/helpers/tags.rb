helpers do
  # this method is so ugly. Refactor me eventually!
  def find_or_create_tag(tag_name)
    tag_name.gsub!("#", "")
    if Tag.find_by(name: tag_name)
      @tag = Tag.find_by(name: tag_name)
    else
      @tag = Tag.create!(name: tag_name)
    end
    return @tag
  end

  def create_tags(individual_photo)
    all_tags = individual_photo["tags"]
    return if all_tags.nil?
    all_tags.map { |tag_name| find_or_create_tag(tag_name) }
  end
end

