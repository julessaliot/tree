module ApplicationHelper
  def user_avatar(user, options = {})
    return image_tag("avatar-kurt.png", class: "navbar-avatar1") unless user

    options = { height: 80, width: 80, crop: :fill }.merge(options)

    if user.photo.attached?
      cl_image_tag(user.photo.key, options)
    else
      image_tag("avatar-kurt.png", class: "navbar-avatar1")
    end
  end
end
