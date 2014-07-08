class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = User.first #tmp

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

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
