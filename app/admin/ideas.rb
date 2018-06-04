# frozen_string_literal: true

ActiveAdmin.register Idea do
  menu priority: 3
  permit_params do
    %i[theme title description is_display]
  end
end
