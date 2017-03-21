class ActivityTracker < ActiveRecord::Base
  serialize :parameters, Hash
  belongs_to :trackable, polymorphic: true
  belongs_to :recipient, polymorphic: true
end
