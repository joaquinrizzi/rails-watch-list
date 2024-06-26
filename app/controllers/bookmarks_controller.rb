class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create, :destroy]
  before_action :set_bookmark, only: [:destroy]

  def new
    @bookmark = Bookmark.new()
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      # render "lists/show", status: :unprocessable_entity
      @show = true
      render "lists/show", status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
