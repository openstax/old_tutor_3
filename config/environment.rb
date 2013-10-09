# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

# Load the rails application
require File.expand_path('../application', __FILE__)

STANDARD_DATETIME_FORMAT = "%b %d, %Y %l:%M %p %Z"
STANDARD_DATE_FORMAT     = "%b %d, %Y"
STANDARD_TIME_FORMAT     = "%l:%M %p %Z"

SITE_NAME = "OpenStax Tutor"
COPYRIGHT_HOLDER = "Rice University"

require 'cron_jobs'

# Initialize the rails application
Ost::Application.initialize!
