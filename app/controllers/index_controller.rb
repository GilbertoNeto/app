class IndexController < ApplicationController
  before_action :check_signed_in, only: [:login, :signup]

  def index
    if params[:search]
      @businesses = Business.where("name like ?", "%#{params[:search]}%")
    else
      @businesses = Business.all
    end
  end

  def login
  end

  def signup
  end

  def about
  end

  def check_signed_in
    redirect_to '/' if signed_in?
  end

  # def search
  #   @businesses = Business.ransack(params[:search])
  # end
end
