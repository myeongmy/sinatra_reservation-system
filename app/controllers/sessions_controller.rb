class SessionsController < ApplicationController
  def new
  end
  
  def create
    host = Host.find_by(email: params[:email])
    if host && host.authenticate(params[:password])
    log_in(host)
    redirect_to '/home/index'
    else
    #falsh.now[:alert] = "이메일 또는 패스워드가 잘못되었습니다."
    render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to '/home/index'
  end
  
  def join
  end
end
