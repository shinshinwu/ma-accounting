class CourseVideosController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_video_context, except: [:new, :create]

  def new
    @video          = CourseVideo.new
    @course_content = CourseContent.find_by_id(params[:content_id])
    unless @course_content.present?
      flash[:alert] = 'Sorry, associated course module not be found!'
      redirect_to :back and return
    end
  end

  def create
    course_content = CourseContent.find_by_id(params[:course_video][:course_content_id])
    unless course_content.present?
      flash[:alert] = 'Sorry, associated course module not be found!'
      redirect_to :back and return
    end
    @video = CourseVideo.new
    @video.course_content = course_content

    set_video_form_fields

    begin
      @video.save!
      flash[:success] = "Your new video has been successfully added!"
      redirect_to edit_course_module_path(course_content.course_module, anchor: "videos")
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end
  end

  def edit
  end

  def update
    set_video_form_fields

    begin
      @video.save!
      flash[:success] = "Your new video has been successfully updated!"
      redirect_to edit_course_module_path(@video.course_module, anchor: "videos")
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end
  end

  private

  def set_video_context
    @video = CourseVideo.find_by_id(params[:id])
    unless @video.present?
      flash[:alert] = 'Sorry, video could not be found!'
      redirect_to :back and return
    end
  end

  def set_video_form_fields
    @video.sort_order     = params[:course_video][:sort_order]
    # need to sanitize url below
    @video.title          = params[:course_video][:title]
    @video.url            = params[:course_video][:url]
    @video.length_minutes = params[:course_video][:length_minutes]
    @video.length_seconds = params[:course_video][:length_seconds]
  end
end
