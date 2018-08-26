module SessionsHelper
    def log_in(host)
        session[:host_id] = host.id
    end
    
    def log_out
        session.delete(:host_id)
    end
end
