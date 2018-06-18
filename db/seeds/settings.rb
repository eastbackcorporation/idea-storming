# frozen_string_literal: true

default_ui_theme = Setting.find_or_initialize_by(name: 'ui_theme', value: 'default')
default_ui_theme.save
