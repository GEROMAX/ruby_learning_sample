require "./lib/data_cache"
require "./lib/safe_file_name"

class CacheManager
  include DataCache
  include SafeFileName

  def initialize(cache_file_name)
    @cache_file_name = cache_file_name
  end

  def exists_cache?
    File.exists?(@cache_file_name)
  end

  def delete_cache
    File.delete(@cache_file_name) if exists_cache?
    self
  end

  def dump(data)
    super(data, @cache_file_name)
    data
  end

  def load
    super(@cache_file_name)
  end
end
