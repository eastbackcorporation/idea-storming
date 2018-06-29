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
end
