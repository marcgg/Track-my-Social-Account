class PubAccountsController < ApplicationController
  def create
    klass = params[:type].constantize
    @pub_account = PubAccount.find_by_account(params[:pub_account][:account])
    @pub_account = klass.create!(params[:pub_account]) if @pub_account.nil?
    redirect_to pub_account_path(@pub_account)
  end
  
  def show
    @pub_account = PubAccount.find(params[:id])
  end
end
