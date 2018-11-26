class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index

    @movies = Tmdb::Movie.popular
    @movies = @movies.results

    if params[:sort_by] == "title"
			@movies = @movies.sort_by &:title
		elsif params[:sort_by] == "release_date"
			@movies = @movies.sort_by &:release_date
		elsif params[:sort_by] == "genre"
			@movies = @movies.sort_by &:genre
		end

  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Tmdb::Movie.detail(params[:id])
    @all_reviews = Review.all
    @this_movie_reviews = []

    @all_reviews.each do |review|
      if review.title == @movie.title
        @this_movie_reviews << review
      end
    end
  end
  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Tmdb::Movie.detail(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.fetch(:movie, {})
    end
end
