class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]
  def index
    @reviews = Review.all
  end

  def show; end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review.cocktail = @cocktail
    if @review.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      @cocktail = Cocktail.find(review_params[:cocktail_id])
      redirect_to cocktail_path(@cocktail)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to cocktail_path(@review.cocktail)
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating, :cocktail_id)
  end
end
