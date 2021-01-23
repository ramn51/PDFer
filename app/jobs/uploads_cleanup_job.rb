class UploadsCleanupJob < ApplicationJob
  queue_as :default

  def perform(path)

    if File.exist?(path)
      logger.debug "File exists in path: #{path}"
      begin
        File.delete(path)
      rescue => e
        logger.debug "File couldnt be deleted due to #{e} in path #{path}"
      end
    end

  end
end
