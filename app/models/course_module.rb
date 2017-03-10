class CourseModule < ActiveRecord::Base
  belongs_to :unit, inverse_of: :course_modules
  has_one :course_content, inverse_of: :course_module, dependent: :destroy
  has_many :supporting_materials, inverse_of: :course_module, dependent: :destroy
  has_many :course_completions, inverse_of: :course_module, dependent: :destroy
  has_one :quizz, class_name: "Quizz", inverse_of: :course_module, dependent: :destroy

  scope :sorted, -> { order(:sort_order) }

  validates_uniqueness_of :sort_order, scope: :unit_id

  def completed_for_user?(user)
    # all quizzes completed passing thredshold
    quizz.passed_by_user?(user)
  end

  def locked_for_user?(user)
    # either unit is greater or the module sort order is greater
    self > user.course_progress.current_module
  end

  # a module is considered greater than the other module if the sort order is higher
  def >(other_module)
    if other_module.unit == unit
      sort_order > other_module.sort_order
    else
      unit.sort_order > other_module.unit.sort_order
    end
  end

  def <(other_module)
    !(self > (other_module)) && (self != other_module)
  end

  def completion_date_for_user(user)
    user.course_completions.by_module(self).first.try(:completion_date)
  end

  # TODO: this should probably be denormalized to module table
  def length
    min = 0
    sec = 0
    course_content.course_videos.each do |vid|
      min += vid.length_minutes
      sec += vid.length_seconds
    end

    if sec >= 60
      min += sec / 60
      sec = sec % 60
    end

    "#{min.to_s.rjust(2, '0')}:#{sec.to_s.rjust(2, '0')}"
  end

  # returns the next upcoming module after current
  def next_module
    # if it's the last module in unit, advance to next unit
    if unit.course_modules.sorted.last == self
      Unit.sorted
        .where('sort_order > ?', unit.sort_order)
        .first
        .course_modules
        .sorted
        .first
    # if there is more module in the unit, advance to next module
    else
      unit.course_modules.sorted.where('sort_order > ?', sort_order).first
    end
  end

end
