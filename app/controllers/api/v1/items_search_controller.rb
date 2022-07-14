class Api::V1::ItemsSearchController < ApplicationController
#   def show
#     items = Item.all
#     if params[:name] != nil
#       items = items.find_by_name(params[:name])
#     end
#
#     if params[:min_price] != nil
#       items = items.find_by_min_price(params[:min_price])
#     end
#
#     if params[:max_price] != nil
#       items = items.find_by_max_price(params[:max_price])
#     end
#
#     if items.length != 0
#       binding.pry
#       render json: ItemSerializer.new(items.first)
#     else
#       render json: EmptySerializer.empty
#     end
#   end
# end


  def show
    search_term_count = 0
    if params[:name] != nil
      search_term_count = search_term_count + 1
      search_term = "name"
    end
    if params[:min_price] != nil
      search_term_count = search_term_count + 1
      search_term = "min_price"
    end
    if params[:max_price] != nil
      search_term_count = search_term_count + 1
      if search_term == "min_price"
        search_term = "price_range"
      end
      search_term = "max_price"
    end

    if search_term_count > 1 && search_term != "price_range"
      render json: { "error": "Name and price can not be searched for simultaneously"}, status: 400
    elsif search_term == "price_range"
      render json: ItemSerializer.new(Item.find_by_price_range(params[:min_price],params[:max_price]))
    elsif search_term == "max_price"
      if params[:max_price].to_f <= 0
        render json: { "error": "Min Price must be greater than 0"}, status: 400
      else
        render json: ItemSerializer.new(Item.find_by_max_price(params[:max_price]).first)
      end
    elsif search_term == "min_price"
      if params[:min_price].to_f <= 0
        render json: { "error": "Min Price must be greater than 0"}, status: 400
      elsif Item.find_by_min_price(params[:min_price]).length > 0
        render json: ItemSerializer.new(Item.find_by_min_price(params[:min_price]).first)
      else
        render json: EmptySerializer.empty
      end
    elsif search_term == "name"
      render json: ItemSerializer.new(Item.find_by_name(params[:name]))
    end
  end
end
