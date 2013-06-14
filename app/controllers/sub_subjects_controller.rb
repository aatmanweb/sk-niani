class SubSubjectsController < ApplicationController

layout 'admin'

  before_filter :confirm_logged_in
  before_filter :find_subject
  
  def index
    list
    render('list')
  end

  def list
    @subsubjects = SubSubject.sorted.where(:subject_id => @subject.id)
  end
  
  def show
    @subsubjects = SubSubject.find(params[:id])
  end

  def new
    @subsubjects = SubSubject.new(:subject_id => @subject.id)
    @images = Image.order(:name)
    @subsubjects_count = @subject.sub_subjects.size + 1
    @subjects = Subject.order('position ASC')
  end


def create
    new_position = params[:sub_subject].delete(:position)
    @images = Image.order(:name)
    # Instantiate a new object using form parameters
    @subsubjects = SubSubject.new(params[:sub_subject])
    # Save the object
    if @subsubjects.save
      @subsubjects.move_to_position(new_position)
      # If save succeeds, redirect to the list action
      flash[:notice] = "Sub Subject created."
      redirect_to(:action => 'list', :subject_id => @subsubjects.subject_id)
    else
      # If save fails, redisplay the form so user can fix problems
      @subsubjects_count = @subject.sub_subjects.size + 1
      @subjects = Subject.order('position ASC')
      render('new')
    end
  end

def edit
    @subsubjects = SubSubject.find(params[:id])
    @images = Image.order(:name)
    @subsubjects_count = @subject.sub_subjects.size
    @subjects = Subject.order('position ASC')
  end
  
  def update
    new_position = params[:sub_subject].delete(:position)
@images = Image.order(:name)
    # Find object using form parameters
    @subsubjects = SubSubject.find(params[:id])
    # Update the object
    if @subsubjects.update_attributes(params[:sub_subject])
      @subsubjects.move_to_position(new_position)
      # If update succeeds, redirect to the list action
      flash[:notice] = "Sub Subject updated."
      redirect_to(:action => 'show', :id => @subsubjects.id, :subject_id => @subsubjects.subject_id)
    else
      # If save fails, redisplay the form so user can fix problems
      @subsubjects_count = @subject.sub_subjects.size
      @subjects = Subject.order('position ASC')
      render('edit')
    end
  end

 def delete
    @subsubjects = SubSubject.find(params[:id])
   @images = Image.order(:name)
  end
  
  def destroy
    @subsubjects = SubSubject.find(params[:id])
    @images = Image.order(:name)
    @subsubjects.move_to_position(nil)
    @subsubjects.destroy
    flash[:notice] = "Sub Subject destroyed."
    redirect_to(:action => 'list', :subject_id => @subject.id)
  end
  
  private
  
  def find_subject
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end
end

