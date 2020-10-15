class AccountsController < ApplicationController

  def balance
    @account = Account.find(params[:id])

    render json: { message: "Saldo total: #{@account.balance}"}, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'A conta não existe' }, status: :not_found
  end

  def deposit
    @account = Account.find(params[:id])

    value = params[:value].to_i

    unless value.positive?
      render json: { message: 'Valor inválido' }, status: :bad_request and return
    end

    if @account
      Accounts::Deposit.call(@account, value)

      render json: { message: 'Valor depositado' }, status: :ok
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'A conta não existe' }, status: :not_found
  end

  def withdrawal
    @account = Account.find(params[:id])

    value = params[:value].to_i

    unless value.positive?
      render json: { message: 'Valor inválido' }, status: :bad_request and return
    end

    if @account
      Accounts::Withdrawal.call(@account, value)

      render json: { message: 'Valor sacado' }, status: :ok
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'A conta não existe' }, status: :not_found
  end

  def transfer
    @sender = Account.find(params[:id])
    @receiver = Account.find(params[:receiver_id])

    value = params[:value].to_i

    unless value.positive?
      render json: { message: 'Valor inválido' }, status: :bad_request and return
    end

    if @sender && @account
      Services::Accounts::Transfer.call(@sender, @receiver, value)

      render json: { message: 'Valor transferido' }, status: :ok
    else
      render json: { message: 'Uma das contas não existe' }, status: :not_found
    end
  end

  private

  def account_params
    params.require(:transaction).permit(:receiver_id, :value)
  end
end
