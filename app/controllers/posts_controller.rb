class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]
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

    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = "Your post was created."
          redirect_to posts_path
        else
          render :new
        end
      end

      format.js do
        @post.save
      end
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

  private
	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :url, :description, category_ids: [])
	end
end
