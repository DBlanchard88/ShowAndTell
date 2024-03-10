class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 1}
  validates :body, presence: true, length: {minimum: 5}
  belongs_to :user #post belongs to user
  has_many :comments, dependent: :destroy #delete the post and we destroy all the comments
  has_rich_text :body

  has_many :notifications, through: :user, dependent: :destroy, class_name: "Noticed::Notification"
end
