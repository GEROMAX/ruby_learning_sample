require "date"
require "open-uri"
require "logger"
require "./lib/jpx_data_manager"

# e_logger = Logger.new(STDERR)
# i_logger = Logger.new(STDOUT)

begin
  infos = JPXDataManager.new.load_jpx_data
  puts infos.inspect
end
