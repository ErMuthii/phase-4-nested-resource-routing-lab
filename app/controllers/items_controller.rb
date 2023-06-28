class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

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
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items.find( params[:id])
    else
      items = Item.find(params[:id])
    end
    render json: items, include: :user
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items.create(items_params)
    
     else
      items = Item.new(items_params)
    end
    render json: items , include: :user, status: :created
  end

  private

  def items_params
    params.permit(:name, :description, :price)
  end


  def render_not_found_response
    render json: {error: "Item not found"}, status: :not_found
  end

end
