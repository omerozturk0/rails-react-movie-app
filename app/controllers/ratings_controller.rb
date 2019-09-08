class RatingsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  # POST /ratings
  def create
    @rating = current_user.ratings.where(movie_id: params[:movie_id]).first || current_user.ratings.new(rating_params)

    if @rating.present? ? @rating.update(rating_params) : @rating.save
      render json: @rating, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:movie_id, :value)
    end
end
