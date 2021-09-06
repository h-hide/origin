class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :memos, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_memos, through: :likes, source: :memo
  has_many :comments, dependent: :destroy

  validates :comment_text, presence: true, length: { maximum: 1000 }

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  mount_uploader :image, ImageUploader

  def already_liked?(memo)
    likes.exists?(memo_id: memo.id)
  end
end
