# frozen_string_literal: true
class PortfolioStocksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_portfolio, only: [:new]
  before_action :find_portfolio_stock, only: [:destroy]

  def new
    @portfolio_stock = PortfolioStock.new
  end

  def create
    stock = Stock.available.find_by(ticker: ticker)
    return redirect_to new_portfolio_stock_path, notice: 'stock is not exist' if stock.blank?

    @portfolio_stock = PortfolioStock.new(portfolio_id: portfolio_id, ticker: ticker)

    redirect_to portfolios_path if @portfolio_stock.save
  rescue ActiveRecord::RecordNotUnique
    redirect_to new_portfolio_stock_path, notice: 'you are already add this stock'
  end

  def destroy
    @portfolio_stock.destroy if @portfolio_stock
    redirect_to portfolios_path
  end

  private

  def user_portfolios
    current_user.portfolios
  end

  def find_portfolio
    @portfolio = user_portfolios.find(portfolio_id)
  end

  def find_portfolio_stock
    @portfolio_stock = PortfolioStock.find_by(portfolio_id: portfolio_id, ticker: ticker)
  end

  def portfolio_id
    params[:portfolio_id]
  end

  def ticker
    params[:ticker]
  end
end
