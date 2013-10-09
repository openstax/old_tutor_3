# Copyright 2011-2012 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module Ost
  module Cron

    ##
    ## NOTE: Changes here should also be reflected in:
    ##   config/schedules.rb
    ##   app/controllers/dev_controller.rb (and related views)
    ##

    def self.execute_cron_jobs
      execute_5min_cron_jobs
      execute_30min_cron_jobs
      execute_60min_cron_jobs
    end

    def self.execute_5min_cron_jobs
      log_and_execute "5 min cron jobs" do

        # log_and_execute "name of some action here" do
        #   # some action here
        # end

      end
    end

    def self.execute_30min_cron_jobs
      log_and_execute "30 min cron jobs" do
        # ...
      end
    end

    def self.execute_60min_cron_jobs
      log_and_execute "60 min cron jobs" do
        # ...
      end
    end

    def self.log_and_execute(name)
      Rails.logger.info "CRON: #{Time.now} begin #{name}"
      yield
      Rails.logger.info "CRON: #{Time.now} end   #{name}"
    end

  end
end