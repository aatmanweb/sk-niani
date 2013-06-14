class SearchEngOptsController < ApplicationController
 
  def index   
   @keyword = SearchEngOpt.all
   @keyword = SearchEngOpt.paginate :page => params[:page], :per_page => 3
  end

  def new
    @keyword = SearchEngOpt.new
    @meta_id = params[:meta_id]
    @meta_type = params[:meta_type]
  end

  def create
    @keyword = SearchEngOpt.new(params[:keyword])
    if @keyword.save           
      redirect_to :action => "show", :id => @keyword
    else
      redirect_to :action => "new", :meta_id => params[:meta_id], :meta_type => params[:meta_type]
    end
  end

  def show
    @keyword = SearchEngOpt.find(params[:id])
  end

  def edit
    @keyword = SearchEngOpt.find(params[:keyword])
    @meta_id = @keyword.meta_id
    @meta_type = @keyword.meta_type
  end 

  def update
    @keyword = SearchEngOpt.find(params[:id])
 
    if @keyword.update_attributes(params[:keyword])
       redirect_to :action => 'show', :id => @keyword
    else
       redirect_to :action => "edit", :keyword => @keyword
    end
  end
  
end
