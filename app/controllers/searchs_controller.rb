class SearchsController < ApplicationController

  def query
    @posts = Post.search(params[:query])
    if @posts.blank?
      flash[:success] = 'No result found.'
      redirect_to :back
    else
      render 'posts/index'
    end
  end
end
