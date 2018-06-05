# frozen_string_literal: true

ActiveAdmin.register Theme do
  menu priority: 2

  filter :title
  filter :description
  filter :category
  filter :tags
  filter :owner
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :title
    column :description
    column :owner
    column :category
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :owner
      row :category
      row :created_at
      row :updated_at
      row :ideas do
        render 'admin/themes/show/tree', ideas: theme.ideas
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      input :title
      input :description
      input :owner_id, as: :select, include_blank: false,
                       collection: User.general_users.map { |user| [user.nick_name, user.id] }
      input :category_id, as: :select, include_blank: false,
                          collection: ancestry_options(Category.all.arrange(order: :disp_order))
      render 'admin/themes/edit/tree', ideas: f.object.ideas
    end
    f.actions
  end

  permit_params do
    %i[title description owner category_id]
  end
end
