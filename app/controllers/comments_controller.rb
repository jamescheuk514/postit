class CommentsController < ApplicationController
  include VotesHelper
  before_action :find_comment, only: [:vote, :undo_vote]
  before_action :signed_in_user

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = @current_user

    respond_to do |format|

      format.html do
        if @comment.save
          flash[:success] = "Created a comment"
          redirect_to post_path(@post)
        else
          render "posts/show"
        end
      end

      format.js do
        @comment.save
      end
    end
  end

  def vote
    @vote = @comment.votes.create(user_id: @current_user.id, vote: params[:vote])

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
    @comment.votes.where(user_id: @current_user.id).destroy_all
    respond_to do |format|
      format.html do
        flash[:success] = "Undo voting"
        redirect_to :back
      end
      format.js
    end
  end


  private
  
  def find_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:body)
  end
end
