# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  nick_name              :string(255)      not null
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE), not null
#  avatar_color           :integer          default("blue")
#

FactoryBot.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:nick_name) { |n| "nick_name#{n}" }
    password 'password'
    password_confirmation 'password'
  end
end
