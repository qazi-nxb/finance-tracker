class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_exists?(ticker_symbol)
    stock = Stock.db_search(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_limit
    stocks.count < 10
  end

  def can_track?(ticker_symbol)
   under_limit && !stock_exists?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Annonymous"
  end

end
