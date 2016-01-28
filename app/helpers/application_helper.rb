module ApplicationHelper

  def grab_picture(user, options = {size: 80}) #assim é como se passa um argumento tendo este um value default
    image_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    image_url = "https://secure.gravatar.com/avatar/#{image_id}?s=#{size}"
    image_tag( image_url, class: 'img-circle' )
  end

end
