# frozen_string_literal: true

shared_context 'Regist Categories' do
  before do
    load(File.join(Rails.root, 'db', 'seeds', 'category_types.rb'))
    load(File.join(Rails.root, 'db', 'seeds', 'categories.rb'))
  end
end
