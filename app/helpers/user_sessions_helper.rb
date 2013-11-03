module UserSessionsHelper
  def bad_login?
    has_flash? && flash_class == 'alert-danger'
  end

  def form_group_class
    if bad_login?
      'form-group has-error'
    else
      'form-group'
    end
  end
end
