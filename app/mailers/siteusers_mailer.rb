class SiteusersMailer < ActionMailer::Base
  #default from: "from@example.com"
  def welcome_email(siteuser)
    @siteuser = siteuser
    @siteusername = siteuser.username
    @url  = 'http://simplyknowledge.com/siteusers/siteuserverify?username=#{@siteusername}&status=active'
    mail(:to => siteuser.email, :subject => "Welcome to My Simplyknowledge.com", :from => "aatmanweb@gmail.com")
  end
end
