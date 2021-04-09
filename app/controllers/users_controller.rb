class UsersController < ApplicationController
  def my_portfolio
    @track_stocks =  current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friendresult'}
        end
      else
        #binding.pry
        respond_to do |format|
          flash.now[:alert] = "please enter a valid symbol to search"
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
