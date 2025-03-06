class Comment < ApplicationRecord
  # コメントをユーザー、タスクに紐付け
  belongs_to :user
  belongs_to :task

  # 空のコメントを防ぐ
  validates :content, presence: true
end
