class CourseCompletion < ActiveRecord::Base
  belongs_to :course_progress, inverse_of: :course_completions
  belongs_to :course_module, inverse_of: :course_completions

  delegate :user, to: :course_progress

  scope :by_module, -> (course_module) { where(course_module_id: course_module)}
  scope :by_user, -> (user) {
    joins(:course_progress)
    .where("course_progresses.user_id = ?", user.id)
  }

  private

end
