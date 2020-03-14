class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show update destroy]
  before_action :new_cocktail, only: %i[index show search_index]
  def index
    @cocktails = Cocktail.all
  end

  def show
    @doses = Dose.where(cocktail_id: params[:id])
    @dose = Dose.new
    @reviews = Review.where(cocktail_id: params[:id])
    @review = Review.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def update
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail)
    else
      render :edit
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to root_path
  end

  def search
    if params[:search][:query] != ""
      @search = params[:search][:query]
      @cocktails = Cocktail.where('name ILIKE ?', "%#{params[:search][:query]}%")
      redirect_to search_result_path(params[:search][:query])
    else
      redirect_to request.referrer
    end
  end

  def search_index
    @cocktails = Cocktail.where('name ILIKE ?', "%#{params[:query]}%")
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def new_cocktail
    @new_cocktail = Cocktail.new
  end

  def cocktail_params
    params[:cocktail][:name].capitalize!
    params.require(:cocktail).permit(:name, :photo)
  end
end
