# frozen_string_literal: true

ActiveAdmin.register Category do
  menu priority: 4

  permit_params do
    %i[name description disp_order ancestry]
  end

  index do
    render 'admin/categories/tree'
  end

  form do |f|
    category.parent = Category.find params[:parent_category_id] if params[:parent_category_id].present?

    f.semantic_errors
    f.inputs do
      input :name
      input :description
      input :disp_order
      input :ancestry, as: :hidden
    end
    f.actions
  end

  # controller do
  #   def index
  #     super
  #   end
  #
  #   def edit
  #     super
  #   end
  #
  # end
end
