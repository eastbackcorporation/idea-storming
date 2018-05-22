class Theme < ApplicationRecord
  belongs_to :owner, class_name: "User"

  validates :title, presence: true

  def owner?(user)
    owner == user
  end
end
