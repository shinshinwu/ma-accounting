# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# some app wide date and time formats goes here
Date::DATE_FORMATS[:default]   = "%m/%d/%y"
Date::DATE_FORMATS[:wday_month] = '%a, %b %d'

# need to adjust to timezone here
Time::DATE_FORMATS[:full]      = "%m/%d/%Y %H:%M"
Time::DATE_FORMATS[:month_day] = "%b %e"
Time::DATE_FORMATS[:hour_min]  = "%l:%M %P"
