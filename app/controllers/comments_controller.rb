class CommentsController < ApplicationController

  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save

      respond_to do |format|
        format.html { redirect_to @post || root_path }
        format.js
      end
      # removed flash message as the refresh should only update the content of the comments div
    else
      flash[:alert] = "Error. Please try again."
      redirect_to root_path
    end

  end

  def destroy

    @comment = @post.comments.find(params[:id])

    if current_user.id == @comment.user.id && @comment.delete
      respond_to do |format|
        format.html {redirect_to @post}
        format.js
      end
    else
      flash[:alert] = "Unable to remove comment."
      redirect_to @post
    end

  end

  private

  def comment_params
      params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
