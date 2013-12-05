require 'redcarpet/render_strip'

module ApplicationHelper
  def has_flash?
    flash[:status] != nil
  end

  def flash_class
    'alert ' + flash[:status]
  end

  def flash_notice
    flash[:notice]
  end

  def logged_in?
    session[:user_id] != nil
  end

  def current_user
    if logged_in?
      User.find_by_id session[:user_id]
    else
      nil
    end
  end

  def admin?
    u = current_user
    u && u.admin
  end

  def partial(file, locals = {})
    render partial: file, locals: locals
  end

  @@markdown = nil
  @@stripped_markdown = nil

  def md(text)
    unless @@markdown
      render_options = { filter_html: true, no_styles: true, safe_links_only: true }
      renderer = Redcarpet::Render::HTML.new(render_options)
      @@markdown = Redcarpet::Markdown.new(renderer, autolink: true)
    end

    @@markdown.render(text).html_safe
  end

  def smd(text)
    unless @@stripped_markdown
      renderer = Redcarpet::Render::StripDown.new
      @@stripped_markdown = Redcarpet::Markdown.new(renderer, autolink: true)
    end

    @@stripped_markdown.render(text)
  end
end
