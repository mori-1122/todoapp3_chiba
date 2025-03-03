class User < ApplicationRecord
  # 1人の User は複数の Board を持つことができる。 User が削除されたら、その User に紐づく Board,task も一緒に削除される。
  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
