class Api::V1::ItemsSearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find_by_name(params[:name]))
  end
end
