class CommentsController < ApplicationController
layout 'admin'
before_filter :confirm_logged_in, :except => [:create]

def index
@pages = Comment.all
@subjects = Comment.order('page_id DESC').group('page_id')
@pagecommentcount = Comment.order('page_id DESC').group('page_id').size
end
def new

end 
def create
   @post = Page.find(params[:page_id])
   @comment_new = @post.comments.create(params[:comment])  
       if @comment_new.save
      flash[:notice] = 'Thank you for your comments.'
      redirect_to(:back)
      end
end

def list
@comment = Comment.where(:page_id =>params[:page_id])
end

def show
@comment = Comment.where(:page_id => params[:page_id])
end

def edit
@comment = Comment.find(params[:id])
end

def update
@section = Comment.find(params[:id])
    if @section.update_attributes(params[:comment])
    
      flash[:notice] = "Comment updated."
      redirect_to(:action => 'show', :id => @section.id, :page_id => @section.page_id)
    else
      @section_count = @page.sections.size
      @pages = Page.order('position ASC')
      render('edit')
    end
end

def delete
 @comment = Comment.find(params[:id])
end

def destroy
 comment = Comment.find(params[:id])
        comment.destroy
    flash[:notice] = "Comment destroyed."
    redirect_to(:action => 'show', :page_id => params[:page_id])
end
end
