class PostsController < ApplicationController
  include VotesHelper
  before_action :find_post, only: [:show, :edit, :update, :vote]
  before_action :signed_in_user, except: [:index, :show]

  def index
    @posts = Post.order("created_at DESC").all
  end

	def show
	  @comment = Comment.new
  end

	def new
    @post = Post.new
	end

	def create
    @post = Post.new(post_params)
    @post.creator = @current_user

    if @post.save
      flash[:success] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

	def update
    if @post.update(post_params)
      flash[:success] = "Updated successful"
      redirect_to @post
    else
      render :edit
    end
	end

  def vote
    @vote = @post.votes.create(user_id: @current_user.id, vote: params[:vote])

    unless @vote.valid?
      flash[:warning] = "You've voted before."
    end

    redirect_to :back
  end

  private
	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :url, :description, category_ids: [])
	end
end
