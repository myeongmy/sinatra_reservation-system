class SessionController < ApplicationController
  def new
  end
  
  def create
    host = Host.find_by(name:params[:name])
    if host && host.authenticate(params[:password])
    session[:host_id] = host.id
    redirect_to :root
    else
    #falsh.now[:alert] = "이메일 또는 패스워드가 잘못되었습니다."
    render 'new'
    
    end
  end
end
