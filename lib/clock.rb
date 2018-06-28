require 'clockwork'
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

module Clockwork
  handler do |job|
    system(job)
  end

  every(1.day, 'ApiKeyInactiveDeletionJob') {
    ApiKeyInactiveDeletionJob.perform_later
  }

  every(1.day, 'ApiKeyInactiveWarningJob') {
    ApiKeyInactiveWarningJob.perform_later
  }
end
