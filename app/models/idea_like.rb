# frozen_string_literal: true

class IdeaLike < ApplicationRecord
  belongs_to :idea
  belongs_to :user
end
