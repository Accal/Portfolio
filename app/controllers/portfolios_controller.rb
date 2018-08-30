class PortfoliosController < ApplicationController
  access all: [:show, :index, :angular], user: { except: [:destroy, :new, :create, :update, :edit] }, site_admin: :all
  skip_before_action :verify_authenticity_token
  before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  layout 'portfolio'

  def index
    @portfolio_items = Portfolio.by_position
  end

  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    render nothing: true
  end

  def method_name
    @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
    3.times {@portfolio_item.technologies.build}
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.'}
      else
        format.html { render :new }
      end
    end
  end

  def edit
    3.times {@portfolio_item.technologies.build}
  end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'Reccord was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  def destroy
    @portfolio_item.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was removed.'}
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title,
                                      :subtitle,
                                      :body,
                                      technologies_attributes: [:name]
                                      ) 
  end

  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end
end