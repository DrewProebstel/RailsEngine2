class Api::V1::ItemsSearchController < ApplicationController
  def show
    if Item.find_by_name(params[:name]).length == 0
      render json: EmptySerializer.empty
    else
      render json: ItemSerializer.new(Item.find_by_name(params[:name]).first)
    end
  end
end
