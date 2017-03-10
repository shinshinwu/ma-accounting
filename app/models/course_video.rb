class CourseVideo < ActiveRecord::Base
  belongs_to :course_content, inverse_of: :course_videos

  validates_uniqueness_of :url

  scope :sorted, -> { order(:sort_order) }

  delegate :course_module, to: :course_content

  validates_uniqueness_of :sort_order, scope: :course_content_id
  validates :length_minutes, numericality: { greater_than: 0, less_than: 60 }
  validates :length_seconds, numericality: { greater_than: 0, less_than: 60 }


  def duration
    "#{length_minutes}:#{length_seconds.to_s.rjust(2, '0')} mins"
  end
end
