class PostsController < ApplicationController

  before_action :authenticate_user!

  before_action :owned_posts, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
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
    # @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

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
    @post = Post.find(params[:id])

    if @post.delete
      flash[:notice] = "Problem solved! Post deleted."
      redirect_to root_path
    else
      flash[:alert] = "Error processing. please try again."
      redirect_to @post
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

end
