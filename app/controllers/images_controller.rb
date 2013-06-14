class ImagesController < ApplicationController
  # GET /images
  # GET /images.json
require 'will_paginate/array'
	layout 'admin'
before_filter :confirm_logged_in

  def index
if params[:search]
      @images = Image.find(:all, :conditions => ['name LIKE ? OR name LIKE ?', "%#{params[:search]}%", "%#{params[:search].capitalize}%"], :order => "name ASC").paginate :page => params[:page], :per_page => 10
    else
    @images = Image.all
    @images = Image.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end
end
  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new
    @subjectsid = params[:imageable_id]
    @imagetype = params[:imageable_type]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
    @subjectsid = @image.imageable_id
    @imagetype = @image.imageable_type
 
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

end
