class PostsController < ApplicationController

  before_action :set_new_post, only: [:new, :insta_new]
  before_action :find_post, only: [:show, :edit, :update, :vote, :undo_vote]
  before_action :signed_in_user, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.xml { render xml: @posts }
    end
  end

	def show
	  @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml { render xml: @post }
    end
  end

	def new
	end

  def insta_new
  end

	def create
    if params.include?(:page_url)
      page = MetaInspector.new(params[:page_url],
                              allow_redirections: :all,
                              timeout: 5,
                              html_content_only: true)
      @post = Post.new(title: page.title, url: page.url, description: page.description)
      render :new
    else
      @post = Post.new(post_params)
      @post.creator = @current_user
      if @post.save
        flash[:success] = "Your post was created."
        redirect_to posts_path
      else
        render :new
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

  def vote
    @vote = @post.votes.create(user_id: @current_user.id, vote: params[:vote])

    respond_to do |format|
      format.html do
        unless @vote.valid?
          flash[:warning] = "You've voted before."
        end
        redirect_to :back
      end
      format.js
    end
  end

  def undo_vote
    @post.votes.where(user_id: @current_user.id).destroy_all
    respond_to do |format|
      format.html do
        flash[:success] = "Undo voting"
        redirect_to :back
      end
      format.js
    end
  end

  private
  def set_new_post
    @post = Post.new
  end

  def find_post
		@post = Post.find_by_slug(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :url, :description, :page_url, category_ids: [] )
	end
end
