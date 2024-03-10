class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_rich_text :body

  after_create_commit -> { NewCommentNotifier.with(comment_id: id, post_id: post_id).deliver_later(post.user) }
  before_destroy :cleanup_notifications
  has_many :noticed_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  private

  def notify_recipient
    NewCommentNotifier.with(comment: self, post: post).deliver_later(post.user)

  end

  def cleanup_notifications
    notifications_as_event.destroy_all
  end
end
