# frozen_string_literal: true

ActiveAdmin.register Tag do
  menu priority: 5
  filter :name

  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  permit_params do
    [:name]
  end
end
