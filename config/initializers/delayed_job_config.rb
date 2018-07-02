Delayed::Worker.logger ||= if defined?(Rails)
                             Rails.logger
                           elsif defined?(RAILS_DEFAULT_LOGGER)
                             RAILS_DEFAULT_LOGGER
                           else
                             Logger.new(File.join(@worker_options[:log_dir], 'delayed_job.log'))
                           end
