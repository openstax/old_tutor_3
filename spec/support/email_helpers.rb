# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.


def email_deliveries
  ActionMailer::Base.deliveries
end

def email_deliveries_clear
  ActionMailer::Base.deliveries = []
end
