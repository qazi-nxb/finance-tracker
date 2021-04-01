class StocksController < ApplicationController
    def search
        stock = Stock.look_up(params[:stock])
        render json: stock
    end
end
