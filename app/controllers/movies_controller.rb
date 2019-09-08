class MoviesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :extra_form_variables, only: [:edit, :update, :new, :create]

  include Searchable

  # GET /movies
  # GET /movies.json
  def index
    @movies = searchable

    respond_to do |format|
      format.html
      format.json { render json: @movies, meta: { aggs: @movies.aggs } }
    end
  end

  # GET /movies/own
  # GET /movies/own.json
  def own
    @movies = searchable(true)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @movies, meta: { aggs: @movies.aggs } }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  # GET /movies/new
  def new
    @movie = current_user.movies.new
  end

  # GET /movies/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.new(movie_params)

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
      @movie = current_user.movies.find(params[:id])
    end

    def extra_form_variables
      @categories = Category.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :text, :active, :image_url, :category_id)
    end
end
