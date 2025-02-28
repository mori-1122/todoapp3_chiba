class Board < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {in: 1..255 }
  validates :description, presence: true
end
