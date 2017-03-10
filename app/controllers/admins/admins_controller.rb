class Admins::AdminsController < ApplicationController
  before_filter :authenticate_admin!
  include InboxHelper

  def profile
  end

  def students
  end

  def show_students
    respond_to do |format|
      format.json { render json: DatatableStudents.new(view_context, datatable_config) }
    end
  end

  def update
    current_admin.update(
    params.require(:admin).permit(:email, :first_name, :last_name, :time_zone))

    flash[:success] = "Successfully updated your profile!"
    redirect_to :back
  end

private

  def datatable_config
    return {
      columns: datatable_columns,
      datatable_query: datatable_query
    }
  end

  def datatable_columns
    %w[id first_name course_cohort_id start_date action]
  end

  def datatable_query
    User.includes(:course_cohort).order(:created_at)
  end

end
