require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:account) { FactoryBot.create(:account) }

  describe 'GET #index' do
    subject { get :index }

    context 'when there are accounts' do
      let!(:account) { FactoryBot.create(:account) }

      it 'returns OK status' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to eq(
          {
            message: {
              users: [
                {
                  id: account.user.id,
                  first_name: account.user.first_name,
                  last_name: account.user.last_name,
                  email: account.user.email,
                  account: {
                    id: account.id,
                    account_number: account.account_number,
                    bank_number: account.bank_number,
                    balance: account.balance,
                    user_id: account.user.id
                  }
                }
              ],
              total_users: Account.all.size
            }
          }.to_json
        )
      end
    end
  end

  describe 'GET #balance' do
    subject { get :balance, params: { id: account.id } }

    context 'when the account exists' do
      it 'returns OK status' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include(
          "Saldo total: R$:#{account.balance}".to_json
        )
      end
    end

    context 'when the account doesn\'t exists' do
      subject { get :balance, params: { id: 9999 } }

      it 'returns NOT_FOUND status' do
        subject

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('A conta não existe')
      end
    end
  end

  describe 'POST deposit' do
    subject do
      post :deposit, params: {
        id: account.id,
        value: 400
      }
    end

    context 'when account exists' do
      it 'returns OK status' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('Valor depositado')
      end

      it 'changes the account balance' do
        old_balance = account.balance

        subject

        expect(account.reload.balance).to eq(old_balance + 400)
      end

      context 'when the value is invalid' do
        subject do
          post :deposit, params: {
            id: account.id,
            value: -400
          }
        end

        it 'returns BAD_REQUEST status' do
          subject

          expect(response).to have_http_status(:bad_request)
        end

        it 'returns a json body with a message' do
          subject

          expect(response.body).to include('Valor inválido')
        end
      end
    end

    context 'when the account doesn\'t exists' do
      subject { get :balance, params: { id: 9999 } }

      it 'returns NOT_FOUND status' do
        subject

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('A conta não existe')
      end
    end
  end

  describe 'POST withdraw' do
    subject do
      post :withdraw, params: {
        id: account.id,
        value: 400
      }
    end

    context 'when account exists' do
      it 'returns OK status' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('Valor sacado')
      end

      it 'changes the account balance' do
        old_balance = account.balance


        subject

        expect(account.reload.balance).to eq(old_balance - 400)
      end

      context 'when the value is invalid' do
        subject do
          post :deposit, params: {
            id: account.id,
            value: -400
          }
        end

        it 'returns BAD_REQUEST status' do
          subject

          expect(response).to have_http_status(:bad_request)
        end

        it 'returns a json body with a message' do
          subject

          expect(response.body).to include('Valor inválido')
        end
      end
    end

    context 'when the account doesn\'t exists' do
      subject { get :balance, params: { id: 9999 } }

      it 'returns NOT_FOUND status' do
        subject

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('A conta não existe')
      end
    end
  end

  describe 'POST transfer' do
    let(:receiver) { FactoryBot.create(:account) }

    subject do
      post :transfer, params: {
        id: account.id,
        receiver_id: receiver.id,
        value: 400
      }
    end

    context 'when account exists' do
      it 'returns OK status' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('Valor transferido')
      end

      it 'changes the sender balance' do
        old_balance = account.balance

        subject

        expect(account.reload.balance).to eq(old_balance - 400)
      end

      it 'changes the receiver balance' do
        old_balance = receiver.balance

        subject

        expect(receiver.reload.balance).to eq(old_balance + 400)
      end

      context 'when the value is invalid' do
        subject do
          post :deposit, params: {
            id: account.id,
            value: -400
          }
        end

        it 'returns BAD_REQUEST status' do
          subject

          expect(response).to have_http_status(:bad_request)
        end

        it 'returns a json body with a message' do
          subject

          expect(response.body).to include('Valor inválido')
        end
      end
    end

    context 'when the account doesn\'t exists' do
      subject { get :balance, params: { id: 9999 } }

      it 'returns NOT_FOUND status' do
        subject

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json body with a message' do
        subject

        expect(response.body).to include('A conta não existe')
      end
    end
  end
end
