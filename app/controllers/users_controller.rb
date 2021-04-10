class UsersController < ApplicationController
  before_action :authenticate_user!
  def my_portfolio
    @user = current_user
    @track_stocks =  current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @track_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friendresult'}
        end
      else
        #binding.pry
        respond_to do |format|
          flash.now[:alert] = "please enter a valid username or email to search"
          format.js { render partial: 'users/friendresult'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "please enter a name or email to search"
        format.js { render partial: 'users/friendresult'}
      end
    end
  end
end
