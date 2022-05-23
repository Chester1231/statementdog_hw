# frozen_string_literal: true
class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_portfolio, only: [:edit, :update, :destroy]

  def index
    @portfolios = user_portfolios.includes(:stocks)
  end

  def new
    @portfolio = user_portfolios.new
  end

  def create
    @portfolio = user_portfolios.new(portfolio_params)

    if @portfolio.save
      redirect_to portfolios_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to portfolios_path
    else
      render :edit
    end
  end

  def destroy
    @portfolio.destroy if @portfolio
    redirect_to portfolios_path
  end

  private

  def user_portfolios
    current_user.portfolios
  end

  def find_portfolio
    @portfolio = user_portfolios.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:title)
  end
end
