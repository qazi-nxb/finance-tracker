class StocksController < ApplicationController
    def search
        if params[:stock].present?
            @stock = Stock.look_up(params[:stock])
            if @stock
                respond_to do |format|
                    format.js { render partial: 'users/result'}
                end
            else
                #binding.pry
                respond_to do |format|
                    flash.now[:alert] = "please enter a valid symbol to search"
                    format.js { render partial: 'users/result'}
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "please enter a symbol to search"
                format.js { render partial: 'users/result'}
            end
        end
    end
end
