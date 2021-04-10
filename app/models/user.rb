class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships


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

  def self.search(param)
    param.strip!
    to_return = (email_match(param) + fname_match(param) + lname_match(param)).uniq
    return nil unless  to_return
    to_return
  end

  def self.email_match(param)
    matches('email',param)
  end

  def self.fname_match(param)
    matches('first_name', param)
  end

  def self.lname_match(param)
    matches('last_name', param)
  end

  def self.matches(field,param)
    where("#{field} like ?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id}
  end

  def not_friends?(f_id)
    !self.friends.where(id: f_id).exists?
  end




end
