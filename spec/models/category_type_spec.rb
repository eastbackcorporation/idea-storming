# frozen_string_literal: true

# == Schema Information
#
# Table name: category_types
#
#  id               :bigint(8)        not null, primary key
#  type_name        :string(255)      not null
#  name             :string(255)      not null
#  disp_order       :integer
#  category_type_id :bigint(8)
#

require 'rails_helper'

RSpec.describe CategoryType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
