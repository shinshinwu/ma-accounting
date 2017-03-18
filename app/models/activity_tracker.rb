class ActivityTracker < ActiveRecord::Base
  serialize :parameters, Hash
end
