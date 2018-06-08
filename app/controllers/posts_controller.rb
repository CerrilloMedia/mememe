class PostsController < ApplicationController
include PostsHelper

  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :owned_posts, only: [:edit, :update, :destroy]


  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def show
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to @post
    else
      flash[:alert] = "Halt, you fiend! You need an image to post here!"
      puts @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)

    if @post.save
      flash[:notice] = "Post updated hombre."
      redirect_to @post
    else
      flash[:alert] = "Something is wrong with your form!"
      render :edit
    end

  end

  def destroy
    if @post.delete
      # flash[:notice] = "Problem solved! Post deleted."
      flash[:notice] = randomDeletionConfirmationMessage
      redirect_to root_path
    else
      flash[:alert] = "Error processing. please try again."
      redirect_to @post
    end

  end

  def like
    if likes_post(@post)
      @post.downvote_from current_user
    else
      @post.liked_by current_user
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def owned_posts
    @post = Post.find(params[:id])

    unless @post.user == current_user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
