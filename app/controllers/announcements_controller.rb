class AnnouncementsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_announcement_context, except: [:index, :new, :create]
  skip_before_filter :verify_authenticity_token, only: [:destroy]

  def index
    @announcements = Announcement.order('start_date DESC')
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new
    @announcement.assign_attributes(
      params.require(:announcement)
        .permit(:course_cohort_id, :start_date, :end_date, :title, :description))

    if @announcement.save
      flash[:success] = "Your announcement has been successfully created!"
      redirect_to announcements_path
    else
      flash[:error] = "Something went wrong while adding your announcement."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @announcement.update_attributes(
      params.require(:announcement)
        .permit(:course_cohort_id, :start_date, :end_date, :title, :description))
      flash[:success] = "Your announcement has been successfully updated!"
      redirect_to announcements_path
    else
      flash[:error] = "Something went wrong while updating your announcement."
      redirect_to :back
    end
  end

  def destroy
    if @announcement.destroy
      flash[:success] = "Announcement has been successfully deleted!"
    else
      flash[:error] = "Sorry, something went wrong while attempting to delete announcement"
    end

    redirect_to announcements_path
  end

  private

  def set_announcement_context
    @announcement = Announcement.find_by_id(params[:id])
    unless @announcement.present?
      flash[:alert] = 'Sorry, announcement could not be found!'
      redirect_to :back and return
    end
  end

end
