module GamesHelper
  def avatar_url_for(user)
    seed = Digest::MD5.hexdigest(user.name.downcase.strip + user.id.to_s)
    "https://api.dicebear.com/9.x/fun-emoji/svg?seed=#{seed}"
  end

  def random_avatar_image_tag(user, options = {})
    image_tag(avatar_url_for(user), options)
  end
end
