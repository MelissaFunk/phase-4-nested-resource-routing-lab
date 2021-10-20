class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    render json: Item.create(item_params), status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def not_found_response
    render json: {error: "user or item not found"}, status: :not_found
  end

end
