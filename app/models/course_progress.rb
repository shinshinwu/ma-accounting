class CourseProgress < ActiveRecord::Base
  belongs_to :user, inverse_of: :course_progress
  belongs_to :current_module, class_name: "CourseModule", foreign_key: "current_module_id"
  has_many :course_completions, inverse_of: :course_progress, dependent: :destroy
end
