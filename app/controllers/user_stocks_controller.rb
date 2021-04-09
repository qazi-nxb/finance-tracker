class UserStocksController < ApplicationController
  def create
    stock = Stock.db_search(params[:ticker])
    if stock.blank?
      # binding.pry
      stock = Stock.look_up(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice]= "Stock #{stock.name} successfully added to your portfolio"
    redirect_to my_portfolio_path
  end
  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user, stock_id: stock).first
    user_stock.destroy
    flash[:notice]="Stock removed successfully"
    redirect_to my_portfolio_path

  end
end
