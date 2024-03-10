# To deliver this notification:
#
# NewComment.with(record: @post, message: "New post").deliver(User.all)

class NewCommentNotifier < ApplicationNotifier
  # Add your delivery methods
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
  notification_methods do
    def message
      @post = Post.find_by(id: params[:post_id])
      @comment = Comment.find_by(id: params[:comment_id])
      @user = User.find_by(id: @comment&.user_id)
      if @post && @comment && @user
        "#{@user.email} commented on #{@post.title.truncate(10)}"
      else
        "Invalid Notification" # Fallback message
      end
    end

    def url
      if params[:post_id].present?
        Rails.application.routes.url_helpers.post_path(params[:post_id])
      else
        "#" # Fallback URL
      end
    end
  end
end
