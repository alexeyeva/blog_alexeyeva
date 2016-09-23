class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def new_post_email(user, blog)
    @user = user
    @blog = blog
    mail(to: user.email, subject: "New post")
  end
end
