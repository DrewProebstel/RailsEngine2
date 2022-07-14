class Api::V1::MerchantsSearchController < ApplicationController
  def show
    if Merchant.find_by_name(params[:name]).length == 0
      render json: EmptySerializer.empty_array
    else
      render json: MerchantSerializer.new(Merchant.find_by_name(params[:name]))
    end
  end
end
