# frozen_string_literal: true
require 'rails_helper'
include ControllerMacros

RSpec.describe PortfolioStocksController, type: :controller do
  describe 'post #create' do
    context 'when user login' do
      login_user
      let(:portfolio) { create(:portfolio, user_id: @user.id) }
      let(:stock) { create(:stock) }

      context 'and stock is not exist' do
        it 'redirect_to portfolio_stocks#new page' do
          post :create, params: { ticker: 'not_exist', portfolio_id: portfolio.id }
          expect(response).to redirect_to(new_portfolio_stock_path)
          expect(response).to have_http_status(302)
          expect(flash[:notice]).to be 'stock is not exist'
        end
      end

      context 'and stock is exist' do
        context 'and not added' do
          it 'create portfolio_stock' do
            post :create, params: { ticker: stock.ticker, portfolio_id: portfolio.id }

            expect(portfolio.portfolio_stocks.first).to have_attributes(
              portfolio_id: portfolio.id, ticker: stock.ticker
            )
          end
        end

        context 'and already added' do
          let!(:portfolio_stock) { PortfolioStock.create(portfolio: portfolio, stock: stock) }

          it 'redirect_to portfolio_stocks#new page' do
            post :create, params: { ticker: stock.ticker, portfolio_id: portfolio.id }

            expect(response).to redirect_to(new_portfolio_stock_path)
            expect(response).to have_http_status(302)
            expect(flash[:notice]).to be 'you are already add this stock'
          end
        end
      end
    end

    context 'when user signup' do
      let(:portfolio) { create(:portfolio) }
      let(:stock) { create(:stock) }

      it 'redirect_to login page' do
        post :create, params: { ticker: stock.ticker, portfolio_id: portfolio.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'get #new' do
    let(:portfolio) { create(:portfolio, user_id: @user.id) }
    context 'when user login' do
      login_user

      it 'render template' do
        get :new, params: { portfolio_id: portfolio.id }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(200)
      end
    end

    context 'when user signup' do
      it 'redirect_to login page' do
        get :new, params: { portfolio_id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'delete #destroy' do
    context 'when user login' do
      login_user
      let(:portfolio) { create(:portfolio, user_id: @user.id) }
      let(:stock) { create(:stock) }
      let(:portfolio_stock) { PortfolioStock.create(portfolio: portfolio, stock: stock) }

      it 'redirect_to portfolios#index page and destroy portfolio_stock' do
        delete :destroy, params: { ticker: stock.ticker, portfolio_id: portfolio.id }
        expect(response).to redirect_to(portfolios_path)
        expect(response).to have_http_status(302)
        expect(portfolio.portfolio_stocks.count).to be_zero
      end
    end

    context 'when user signup' do
      let(:portfolio) { create(:portfolio) }
      let(:stock) { create(:stock) }
      let(:portfolio_stock) { PortfolioStock.create(portfolio: portfolio, stock: stock) }

      it 'redirect_to login page' do
        delete :destroy, params: { ticker: stock.ticker, portfolio_id: portfolio.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
