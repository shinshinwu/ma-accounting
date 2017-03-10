class CourseContent < ActiveRecord::Base
  belongs_to :course_module, inverse_of: :course_content
  has_many :course_videos, inverse_of: :course_content

  scope :sorted, -> { order(:sort_order) }
end
