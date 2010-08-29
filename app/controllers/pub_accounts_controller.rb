class PubAccountsController < ApplicationController
  def create
    klass = params[:type].constantize
    @pub_account = PubAccount.find_by_account(params[:pub_account][:account])
    if @pub_account.nil?
      @pub_account = klass.create!(params[:pub_account]) 
      flash[:notice] = "Ok, got it. We'll start tracking this page from now on!"
    else
      flash[:notice] = "It looks like someone already asked us to track this page, so here is what we fetched so far!"
    end
    redirect_to pub_account_path(@pub_account)
  end
  
  def show
    @pub_account = PubAccount.find(params[:id])
  end
end
