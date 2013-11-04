class UsersMailer < ActionMailer::Base
  include ActionView::Helpers::UrlHelper
  helper :users

  default from: ("themuffinman@cakesenders.com")

  def welcome_email(user)
    @user = user
    @url = link_to :login
    mail(to: @user.email, subject: 'Welcome to CakeSenders!')
  end
end
