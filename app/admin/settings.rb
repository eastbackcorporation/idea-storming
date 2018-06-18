# frozen_string_literal: true

ActiveAdmin.register Setting do
  menu priority: 9999
  permit_params do
    %i[name value]
  end
end
