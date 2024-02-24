class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 1}
  validates :body, presence: true, length: {minimum: 5}
  belongs_to :user #post belongs to user
  has_many :comments, dependent: :destroy #delete the post and we destroy all the comments
end
