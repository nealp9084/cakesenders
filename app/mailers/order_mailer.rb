class OrderMailer < ActionMailer::Base
  def confirmation_email(order)
    @user, @goodie, @destination = order.user, order.goodie, order.destination
    mail(to: @user.email, subject: 'CakeSenders Order Confirmation')
  end
end
