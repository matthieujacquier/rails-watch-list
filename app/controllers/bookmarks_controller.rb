class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      puts @bookmark.errors.full_messages
      render :new, status: :unprocessable_entity
    end
     rescue => e
      puts "❌ ERROR: #{e.class.name} - #{e.message}"
      puts e.backtrace.take(10)  # just top of stack
      render plain: "An error occurred: #{e.message}", status: :internal_server_error

  end

   def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_bookmark_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
     params.require(:bookmark).permit(:comment, :movie_id )
  end

end
