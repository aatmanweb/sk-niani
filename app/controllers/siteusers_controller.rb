class SiteusersController < ApplicationController
 layout 'user'
  
  #before_filter :confirm_logged_in, :except => [:login, :attempt_user_login, :create, :new, :logout]
   
  def attempt_user_login
    authorized_user = Siteuser.authenticate(params[:username], params[:password])
	 @userDetails = Siteuser.find_by_username(params[:username])
     if authorized_user
	@status = @userDetails.status
     	if @status == 'active'
      session[:siteuser_id] = authorized_user.id
      session[:siteusername] = authorized_user.username
      flash[:notice] = "You are now logged in."
      redirect_to(:controller => 'public', :action => 'index')
	else
      flash[:notice] = "Please verify the confirmation link sent through email."
      redirect_to(:action => 'login')
       end
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
    
  end
	def new
    @siteuser = Siteuser.new
  end  
  
 def create
    @siteuser = Siteuser.new(params[:siteusers])
 	if @siteuser
      SiteusersMailer.welcome_email(@siteuser).deliver
     @siteuser.save
      flash[:notice] = 'User created.We have sent you a verification link at the registered email address.'
      redirect_to(:action => 'login')
    else
      render(:controller =>"siteusers", :action => "login")
    end
  end  

 
    
 def siteuserverify  
   @status = Siteuser.find_by_username(params[:username])
   @status.update_attributes(:status => params[:status])
    redirect_to(:action => 'login')
 end  
  
  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have been logged out."
    redirect_to(:controller => 'public', :action => 'index')
  end

end
