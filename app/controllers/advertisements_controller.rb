class AdvertisementsController < ApplicationController
layout 'admin'
before_filter :confirm_logged_in
	def index
	    @advertise = Advertisement.new
	end
	
	def new
	    @advertise = Advertisement.new(params[:advertise])
	    if(@advertise.location_type == "Subject")
	      self.action_for_subjects
	    elsif(@advertise.location_type == "SubSubject")
	      self.action_for_sub_subjects
	    elsif(@advertise.location_type == "Page")
	      self.action_for_pages	    
	    elsif(@advertise.location_type == "Section")
	      action_for_sections
	    end
	
	end
	
	def create
	    @advertise = Advertisement.new(params[:advertise])

	    adv_name = @advertise.adv_name
	    adv_type = @advertise.adv_type
	    adv_url = @advertise.adv_url
	    flashimage = @advertise.flashimage
	    adv_position = @advertise.adv_position
	    location_type = @advertise.location_type
	    expiry_date = @advertise.expiry_date

	    i = 0  
	    @items = params[:location_ids]
	    @items.each do |item|

	     @tag = Advertisement.find_by_location_type_and_location_id_and_adv_position(location_type,item,adv_position)

	     if @tag != nil

		flash[:notice] = 'Advertisement at this place already exists.'		
	     else

		Advertisement.create({:adv_name => adv_name, :adv_type => adv_type, :adv_url => adv_url, :flashimage => flashimage, :adv_position => adv_position, :location_type => location_type, :location_id => item, :expiry_date => expiry_date})  
		flash[:notice] = 'Advertisement was successfully Added.' 

	     end
		    i += 1
	    end	 
	    
	    redirect_to(:action => 'show')    
	    
	end
	
	def edit
	    @advertise = Advertisement.find(params[:id])
	end
	
	def update
	    @advertise = Advertisement.find(params[:id])
	    if @advertise.update_attributes(params[:advertise])
	      # If update succeeds, redirect to the list action
	      flash[:notice] = "advertisement updated."
	      redirect_to(:action => 'show')
            else
	      # If save fails, redisplay the form so user can fix problems
	      @advertise_count = Advertisement.count
	      render('edit')
	    end	    
	end
	
	def delete
		@advertise = Advertisement.find(params[:id])
	end

	def destroy
		Advertisement.find(params[:id]).delete
		flash[:notice] = "Advertisement destroyed."		
		redirect_to(:action => 'show')
	end

	def show
	    @advertise = Advertisement.all
   	    @advertise = Advertisement.paginate :page => params[:page], :per_page => 10
	end
	
  def action_for_subjects
    @advertise = Advertisement.new
    @location_type = "Subject"
    @object = Subject.order('position ASC')
  end

  def action_for_sub_subjects
    @advertise = Advertisement.new
    @location_type = "SubSubject"
    @object = SubSubject.order('position ASC')
  end

  def action_for_pages
    @advertise = Advertisement.new
    @location_type = "Page"
    @object = Page.order('position ASC')
    render 'new'
  end

  def action_for_sections
    @advertise = Advertisement.new
    @location_type = "Section"
    @object = Page.order('position ASC') # pages list    
    render 'pagesList'
  end

  def sectionsList
    @advertise = Advertisement.new(params[:advertise])
    @location_type = @advertise.location_type
    @page_id = params[:id]
    @location_type = params[:location_type]
    @object = Section.where(:page_id => @page_id).order('position ASC') # pages list 
    render 'new'     
  end

end
