class Announcement < ActiveRecord::Base
  belongs_to :course_cohort, inverse_of: :announcements

  scope :by_cohort, -> (cohort) { where(course_cohort_id: cohort.id) }
  scope :currently_active, -> { where("start_date >= ? and (end_date <= ? or end_date is null)", Date.current, Date.current) }

  def is_active?
    (start_date >= Date.current) && (end_date <= Date.current || end_date.nil?)
  end
end
