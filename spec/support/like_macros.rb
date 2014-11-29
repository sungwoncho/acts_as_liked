module LikeMacros
  def create_like(liker, likeable)
    Like.create(likeable_id: likeable.id, likeable_type: likeable.class.base_class.name, liker_id: liker.id, liker_type: liker.class.base_class.name)
  end
end