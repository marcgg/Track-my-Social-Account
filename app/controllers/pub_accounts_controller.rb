class PubAccountsController < ApplicationController
  def index
    @pub_accounts = PubAccount.all
    render :action => "search"
  end
  
  def create
    klass = params[:type].constantize
    @pub_account = PubAccount.find_by_account(params[:pub_account][:account])
    if @pub_account.nil?
      @pub_account = klass.create!(params[:pub_account]) 
      flash[:notice] = t("pub_accounts.create.notice")
    else
      flash[:notice] = t("pub_accounts.create.error")
    end
    redirect_to pub_account_path(@pub_account)
  end
  
  def show
    @pub_account = PubAccount.find(params[:id])
    @totals = @pub_account.stats_entries.map{|se| se.total}
    @min = @totals.min
  end
  
  def search
    @pub_accounts = PubAccount.find(:all, :conditions => {:account => params[:search_value]})
  end
  
  def csv
    @pub_account = PubAccount.find(params[:id])
    csv_string = FasterCSV.generate do |csv|
      csv << ["Data for account #{@pub_account.account} (#{@pub_account.class})"]
      csv << ["date", "count"]
      @pub_account.stats_entries.each do |se|
        csv << [se.when, se.total]
      end
    end

    # send it to the browsah
    send_data(csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=export-#{@pub_account.id}-#{@pub_account.account}.csv")
  end
end
