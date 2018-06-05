# frozen_string_literal: true

ActiveAdmin.register Category do
  menu priority: 4
  config.per_page = 300

  filter :name
  filter :created_at
  filter :updated_at

  index do
    render 'admin/categories/tree'
  end

  form do |f|
    # create child category
    category.parent = Category.find params[:parent_category_id] if params[:parent_category_id].present?

    f.semantic_errors
    f.inputs do
      input :name
      input :description
      input :disp_order
      input :ancestry, as: :hidden if params[:parent_category_id].present?
    end
    f.actions
  end

  permit_params do
    %i[name description disp_order ancestry]
  end
end
