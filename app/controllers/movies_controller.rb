class MoviesController < ApplicationController


  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.find(movie_params)
    if @movie.save
      redirect_to movie_path(@movie)
    else
      render :new, status: :unprocessable_entity
    end
  end

end
