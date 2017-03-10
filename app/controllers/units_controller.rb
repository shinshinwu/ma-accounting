class UnitsController < ApplicationController
  before_filter :authenticate_access!

  def index
    @units = Unit.sorted
    if current_user.present?
      @completed = current_user.completed_modules.size
      @total     = CourseModule.all.size
    end
  end
end
