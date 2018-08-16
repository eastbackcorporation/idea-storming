# frozen_string_literal: true

require Rails.root.join('app', 'lib', 'ui_themes')

module ApplicationHelper
  include ::UiThemes::UiTheme::Helper

  def stylesheet_link_tag(*sources)
    options = sources.last.is_a?(Hash) ? sources.pop : {}
    sources = sources.map do |source|
      if current_ui_theme.present?
        current_ui_theme.stylesheet_path(source) || source
      else
        source
      end
    end
    super *sources, options
  end

  def image_tag(source, options = {})
    source = current_ui_theme.image_path(source) if current_ui_theme.present?
    super source, options
  end

  # helper methods for devise
  # https://github.com/plataformatec/devise/wiki/How-To:-Display-a-custom-sign_in-form-anywhere-in-your-app
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def request_from_path(default_path)
    current_page?(@request_from) ? default_path : (@request_from || default_path)
  end

  def avatar_image(**opts)
    default_opts = {
      user: nil,
      mini_icon: false
    }

    opts = default_opts.merge(opts)
    raise 'user is not presented!' if opts[:user].blank?
    user = opts[:user]
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize: '45x45'), class: 'rounded-circle bg-white').html_safe
    else
      tag.div class: 'avatar' do
        klass_name = if opts[:mini_icon].present?
                       "text-center text-white avatar-circle-mini rounded-circle avatar-#{user.avatar_color}"
                     else
                       "text-center text-white avatar-circle rounded-circle avatar-#{user.avatar_color}"
                     end
        tag.div class: klass_name do
          tag.span do
            user&.avatar_char
          end
        end
      end.html_safe
    end
  end
end
