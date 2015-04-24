class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  respond_to :html

  def index
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    respond_with(@review)
  end

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id  #this is how new reviews are associated with a user
    if @review.save
      redirect_to @review
    else
      render 'new'
    end
  end

  def update
    @review.update(review_params)
    respond_with(@review)
  end

  def destroy
    @review.destroy
    
    redirect_to root_path
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
