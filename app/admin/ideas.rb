# frozen_string_literal: true

ActiveAdmin.register Idea do
  menu priority: 3
  filter :theme
  filter :title
  filter :description
  filter :creator
  filter :theme
  filter :is_display
  filter :updated_at
  filter :created_at

  index do
    selectable_column
    column :theme
    column :title
    column :description
    column :creator
    column :is_display
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      input :theme
      input :title
      input :description
      input :creator_id, as: :select, include_blank: false,
                         collection: User.general_users.map { |user| [user.nick_name, user.id] }
      input :is_display
    end
    f.actions
  end

  permit_params do
    %i[theme title description is_display]
  end
end
