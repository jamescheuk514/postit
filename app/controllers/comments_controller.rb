class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :destroy]

  def index
    @comments = Comment.all
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def find_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
