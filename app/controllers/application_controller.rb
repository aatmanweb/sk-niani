class ApplicationController < ActionController::Base
 protect_from_forgery
  
  protected

def self.search(search_string)
	  search_condition = "%" + search_string + "%"
  	  find(:all, :conditions => ['name LIKE ? OR content LIKE ?', search_condition, search_condition])
	end
     
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false # halts the before_filter
    else
      return true
    end
  end
  

end
