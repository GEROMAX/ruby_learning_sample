require "./lib/jpx_crawl_manager"
require "./lib/jpx_data_reader"
require './lib/cache_manager'

class JPXDataManager
  include JPXCrawlManager
  include JPXDataReader

  CACHE_FILE_NAME = "jpx_company_info.cache"

  def load_jpx_data
    cacher = CacheManager.new(CACHE_FILE_NAME)
    if exists_newest_file?
      return cacher.load if cacher.exists_cache?
    else
      download_xls_from_jpx
    end
    data = data_read_from_file(newest_file_name)
    cacher.delete_cache.dump(data)
  end
end
