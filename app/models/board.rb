class Board < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, presence: { message: 'タイトルを入力してください' }, length: { in: 1..255 }
  validates :description, presence: { message: '文章を入力してください' }
end
