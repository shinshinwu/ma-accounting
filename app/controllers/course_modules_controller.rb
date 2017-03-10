class CourseModulesController < ApplicationController
  before_filter :authenticate_access!, only: [:index, :show]
  before_filter :authenticate_admin!, only: [:new, :create, :edit, :update]
  before_filter :set_module_context, except: [:index, :new]

  def index
    @modules = CourseModule.includes(:unit, course_content: :course_videos).sorted
  end

  def show
    @content     = @module.course_content
    @vids        = @content.course_videos.sorted
    @video       = CourseVideo.find_by_id(params[:video]) || @vids.first
    @quizz       = @module.quizz
    @supporting_images = @module.supporting_materials.joins(:image)
    @supporting_docs   = @module.supporting_materials.joins(:document)
    # there should only be 1 conversation exist for the same user for the same module
    @conversation = Conversation.by_module(@module).sent_by_member(current_user).first
  end

  def new
    @module = CourseModule.new
  end

  def create
  end

  def edit
    @videos      = @module.course_content.course_videos
    @materials   = @module.supporting_materials
  end

  def update
  end

  private

  def set_module_context
    @module = CourseModule.find_by_id(params[:id])
    unless @module.present?
      flash[:alert] = 'Sorry, module not found!'
      redirect_to :back and return
    end

    # TODO: Parse the video id param if exist and play desired vid
  end
end
