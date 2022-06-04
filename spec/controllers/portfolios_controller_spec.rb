# frozen_string_literal: true
require 'rails_helper'
include ControllerMacros

RSpec.describe PortfoliosController, type: :controller do
  describe 'get #index' do
    context 'when user login' do
      login_user

      it 'render template' do
        get :index
        expect(response).to render_template(:index)
        expect(response).to have_http_status(200)
      end
    end

    context 'when user signup' do
      it 'redirect_to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'post #create' do
    context 'when user login' do
      login_user

      context 'and portfolio is blank' do
        it 'redirect_to #index' do
          post :create, params: { portfolio: { title: '我的追蹤清單' } }
          expect(response).to redirect_to(portfolios_path)
          expect(response).to have_http_status(302)
        end

        it 'create portfolio row_order to 1' do
          post :create, params: { portfolio: { title: '我的追蹤清單' } }
          expect(@user.portfolios.first).to have_attributes(title: '我的追蹤清單', row_order: 1)
        end
      end

      context 'and portfolio not blank' do
        let!(:portfolio) { create(:portfolio, user_id: @user.id, row_order: 1) }

        it 'redirect_to #index' do
          post :create, params: { portfolio: { title: '我的追蹤清單' } }
          expect(response).to redirect_to(portfolios_path)
          expect(response).to have_http_status(302)
        end

        it 'create portfolio row_order increment' do
          post :create, params: { portfolio: { title: '我的追蹤清單' } }
          expect(@user.portfolios.last).to have_attributes(title: '我的追蹤清單', row_order: 2)
        end
      end
    end

    context 'when user signup' do
      it 'redirect_to login page' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'get #new' do
    context 'when user login' do
      login_user

      it 'render template' do
        get :new
        expect(response).to render_template(:new)
        expect(response).to have_http_status(200)
      end
    end

    context 'when user signup' do
      it 'redirect_to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'get #edit' do
    context 'when user login' do
      let(:portfolio) { create(:portfolio, user_id: @user.id) }
      login_user

      it 'render template' do
        get :edit, params: { id: portfolio.id }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(200)
      end
    end

    context 'when user signup' do
      let(:portfolio) { create(:portfolio) }
      it 'redirect_to login page' do
        get :edit, params: { id: portfolio.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'patch #update' do
    context 'when user login' do
      login_user
      let(:portfolio) { create(:portfolio, user_id: @user.id) }

      it 'redirect_to #index page and update' do
        patch :update, params: { portfolio: { title: '更新我的追清清單'}, id: portfolio.id }
        expect(response).to redirect_to(portfolios_path)
        expect(response).to have_http_status(302)
        expect(@user.portfolios.first).to have_attributes(title: '更新我的追清清單')
      end
    end

    context 'when user signup' do
      let(:portfolio) { create(:portfolio) }
      it 'redirect_to login page' do
        patch :update, params: { portfolio: { title: '更新我的追清清單'}, id: portfolio.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'delete #destroy' do
    context 'when user login' do
      login_user
      let!(:first_portfolio) { create(:portfolio, user_id: @user.id, row_order: 1) }
      let!(:second_portfolio) { create(:portfolio, user_id: @user.id, row_order: 3) }
      let!(:third_portfolio) { create(:portfolio, user_id: @user.id, row_order: 2) }

      it 'redirect_to #index page and destroy' do
        delete :destroy, params: { id: first_portfolio.id }
        expect(response).to redirect_to(portfolios_path)
        expect(response).to have_http_status(302)
        expect(@user.portfolios.count).to eq 2
      end

      it 'reorder row_order' do
        delete :destroy, params: { id: first_portfolio.id }
        expect(second_portfolio.reload.row_order).to eq 2
        expect(third_portfolio.reload.row_order).to eq 1
      end
    end

    context 'when user signup' do
      let(:portfolio) { create(:portfolio) }
      it 'redirect_to login page' do
        delete :destroy, params: { id: portfolio.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'post #reorder' do
    context 'when user login' do
      login_user
      let!(:first_portfolio) { create(:portfolio, user_id: @user.id, row_order: 1) }
      let!(:second_portfolio) { create(:portfolio, user_id: @user.id, row_order: 2) }

      context 'and position is up' do
        it 'redirect_to #index page' do
          post :reorder, params: { id: second_portfolio.id, position: :up }
          expect(response).to redirect_to(portfolios_path)
          expect(response).to have_http_status(302)
        end

        it 'reorder row_order postion' do
          post :reorder, params: { id: second_portfolio.id, position: :up }
          expect(first_portfolio.reload.row_order).to eq 2
          expect(second_portfolio.reload.row_order).to eq 1
        end
      end

      context 'and position is down' do
        it 'redirect_to #index page' do
          post :reorder, params: { id: first_portfolio.id, position: :down }
          expect(response).to redirect_to(portfolios_path)
          expect(response).to have_http_status(302)
        end

        it 'reorder row_order postion' do
          post :reorder, params: { id: first_portfolio.id, position: :down }
          expect(first_portfolio.reload.row_order).to eq 2
          expect(second_portfolio.reload.row_order).to eq 1
        end
      end
    end
  end
end
