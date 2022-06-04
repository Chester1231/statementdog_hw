# frozen_string_literal: true
class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_portfolio, only: [:edit, :update, :destroy, :reorder]
  after_action :reorder_row_order, only: [:destroy]

  def index
    @portfolios = user_portfolios.ordered_by_row_order.includes(:stocks)
  end

  def new
    @portfolio = user_portfolios.new
  end

  def create
    row_orders = user_portfolios.ordered_by_row_order.pluck(:row_order)
    @portfolio = user_portfolios.new(portfolio_params)
    @portfolio.row_order = row_orders.blank? ? 1 : row_orders.last + 1

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

  def reorder
    case params[:position]
      when 'up'
        ordered_porfolios = user_portfolios.find_by(row_order: @portfolio.row_order-1)
        ordered_porfolios.row_order += 1
        @portfolio.row_order -= 1
      when 'down'
        ordered_porfolios = user_portfolios.find_by(row_order: @portfolio.row_order+1)
        ordered_porfolios.row_order -= 1
        @portfolio.row_order += 1
    end

    ordered_porfolios.save!
    @portfolio.save!
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

  def reorder_row_order
    portfolios = user_portfolios.ordered_by_row_order.where('row_order > ?', @portfolio.row_order)
    return if portfolios.blank?

    portfolios.update_all('row_order = row_order - 1')
  end
end
