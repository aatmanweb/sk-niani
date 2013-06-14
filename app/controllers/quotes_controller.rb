class QuotesController < ApplicationController
require 'will_paginate/array'
layout 'admin'

before_filter :confirm_logged_in

def index
if params[:search]
      @quote = Quote.find(:all, :conditions => ['quote LIKE ? OR quote LIKE ?', "%#{params[:search]}%", "%#{params[:search].capitalize}%"], :order => "quote ASC").paginate :page => params[:page], :per_page => 10
      @authors = Author.order(:author_name)
      @topics = Topic.order(:topic_name)
    else
     @quote = Quote.all
     @quote = Quote.paginate :page => params[:page], :per_page => 10
     @authors = Author.order(:author_name)
     @topics = Topic.order(:topic_name)
         respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quote }
    end
end
end
 # GET /Quotes/1
  # GET /Quotes/1.json
  def show
    @quote = Quote.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /Quotes/new
  # GET /Quotes/new.json
  def new
    @quote = Quote.new
     @authors = Author.order(:author_name)
     @topics = Topic.order(:topic_name)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /Quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
     @authors = Author.order(:author_name)
     @topics = Topic.order(:topic_name)
  end

  # POST /Quotes
  # POST /Quotes.json
  def create
     @authors = Author.order(:author_name)
     @topics = Topic.order(:topic_name)
    @quote = Quote.new(params[:quote])
    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render json: @quote, status: :created, location: @quote }
      else
        format.html { render action: "new" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Quotes/1
  # PUT /Quotes/1.json

  def update

    @quote = Quote.find(params[:id])
       respond_to do |format|
      if @quote.update_attributes(params[:quote])
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Quotes/1
  # DELETE /Quotes/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy
    respond_to do |format|
     format.html { redirect_to @quote }
      format.json { head :no_content }
    end
  end
def sortbyauthor
    @authors = Author.order(:author_name)
    @data_from_select1 = params[:id]
    @quote = Quote.where(:author_id => @data_from_select1).paginate :page => params[:page], :per_page => 5
    @name = Author.find(@data_from_select1)
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quote }
    end
end

def sortbytopic
   @topics = Topic.order(:topic_name)
    @data_from_select2 = params[:id]
    @quote = Quote.where(:topic_id => @data_from_select2).paginate :page => params[:page], :per_page => 5
 @name = Topic.find(@data_from_select2)
         respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quote }
    end
end

end
