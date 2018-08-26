class HostController < ApplicationController
  def new
    
  end
  
  def index
    @host = Host.all
  
  end
  
  def create
   Host.create(name: params[:name],
              email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
  
  redirect_to :root
  end
end
