class Unit < ActiveRecord::Base
  has_many :course_modules, inverse_of: :unit

  scope :sorted, -> { order(:sort_order) }

  def display_name
    "Unit #{sort_order} #{name.titleize}" 
  end
end
