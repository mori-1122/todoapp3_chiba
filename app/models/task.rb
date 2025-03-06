class Task < ApplicationRecord
  has_one_attached :eyecatch
  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :due_date, presence: true
end
