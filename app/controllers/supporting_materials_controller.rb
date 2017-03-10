class SupportingMaterialsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_material_context, except: [:new, :create]

  def new
    @material = SupportingMaterial.new
    @module   = CourseModule.find_by_id(params[:course_module_id])
    unless @module.present?
      flash[:alert] = 'Sorry, associated course module not be found!'
      redirect_to :back and return
    end
  end

  def create
    course_module = CourseModule.find_by_id(params[:supporting_material][:course_module_id])
    unless course_module.present?
      flash[:alert] = 'Sorry, associated course module not be found!'
      redirect_to :back and return
    end
    material               = SupportingMaterial.new
    material.course_module = course_module
    material.title         = params[:supporting_material][:title]
    material.description   = params[:supporting_material][:description]

    image = if params[:supporting_material][:img].present?
      StaticImage.new(img: params[:supporting_material][:img])
    end

    document = if params[:supporting_material][:doc].present?
      DocumentFile.new(doc: params[:supporting_material][:doc])
    end

    begin
      material.save!
      if image.present?
        image.imageable = material
        image.save!
      end
      if document.present?
        document.documentable = material
        document.save!
      end
      flash[:success] = "Your supporting material has been successfully added!"
      redirect_to edit_course_module_path(course_module, anchor: "materials")
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end
  end

  def edit
  end

  def update
    @material.title       = params[:supporting_material][:title]
    @material.description = params[:supporting_material][:description]
    image = if params[:supporting_material][:img].present?
      @material.image = nil if @material.image.present?
      StaticImage.new(img: params[:supporting_material][:img])
    end

    begin
      @material.save!
      if image.present?
        image.imageable = @material
        image.save!
      end
      flash[:success] = "Your supporting material has been successfully updated!"
      redirect_to edit_course_module_path(@material.course_module, anchor: "materials")
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end
  end

  private

  def set_material_context
    @material = SupportingMaterial.find_by_id(params[:id])
    unless @material.present?
      flash[:alert] = 'Sorry, supporting material could not be found!'
      redirect_to :back and return
    end
  end

end
