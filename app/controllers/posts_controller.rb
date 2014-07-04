class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

	def show
	end

	def new

    @post = Post.new
	end

	def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = "Your post was created."
			redirect_to posts_path
    else
      render 'new'
    end
  end


  def edit
  end

	def update
    if @post.update(post_params)
      flash[:success] = "Updated successful"
      redirect_to @post
    else
      render 'edit'
    end
	end

	def destroy
    if @post.destroy
      render 'index'
    end
	end

	private
  	def find_post
  		@post = Post.find(params[:id])
  	end

  	def post_params
  		params.require(:post).permit(:title, :url, :description)
  	end
end
