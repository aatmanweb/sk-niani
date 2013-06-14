class AuthorsController < ApplicationController
require 'will_paginate/array'
	layout 'admin' 
	before_filter :confirm_logged_in
 def index
 if params[:search]
      @authors = Author.find(:all, :conditions => ['author_name LIKE ? OR author_name LIKE ?', "%#{params[:search]}%", "%#{params[:search].capitalize}%"], :order => "author_name ASC").paginate :page => params[:page], :per_page => 10
    else
    @authors = Author.order(:author_name).paginate :page => params[:page], :per_page => 10
    @page_title = "Authors List"
#@authors = Author.paginate :page => params[:page], :per_page => 10	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authors }
    end
  end
end
  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.find(params[:id])    
    @page_title = @author.author_name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @author }
    end
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    @author = Author.new
    @page_title = "New Author"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @author }
    end
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])

  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new
    @author.author_name = params[:author][:author_name].titleize
    @page_title = @author.author_name

    respond_to do |format|
      if @author.save
        format.html {redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render json: @author, status: :created, location: @author }
      else
        format.html { render action: "new" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])

    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :no_content }
    end
  end
end
