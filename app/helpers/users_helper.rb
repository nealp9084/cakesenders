module UsersHelper
  def form_group_class(sym)
    if @user.errors.count == 0
      'form-group'
    elsif @user.errors[sym].empty?
      'form-group has-success'
    else
      'form-group has-error'
    end
  end
end
