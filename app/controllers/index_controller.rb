class IndexController < ApplicationController
  before_action :check_signed_in, only: [:login, :signup]

  def index
    @businesses = Business.all
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

  def search
     @businesses = Business.search_for(params[:search])
    #puts "#{search}"
  end
end
