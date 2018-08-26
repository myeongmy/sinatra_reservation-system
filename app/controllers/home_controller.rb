class HomeController < ApplicationController
  def index
    @current_user = Host.find_by(id: session[:host_id])
  end
  
  def info
    @reservations = Reservation.all
  end
  
  def new
  end
  
  def create
    host = Host.find_by(email:params[:email].downcase)
    if host && host.authenticate(params[:password])
    session[:host_id] = host.id
    redirect_to :root
    else
    falsh.now[:alert] = "이메일 또는 패스워드가 잘못되었습니다."
    render 'index'
    end
  end
  
  
end
