module JPXCrawlManager
  LISTED_COMPANY_FILE_URL = 'http://www.jpx.co.jp/markets/statistics-equities/misc/tvdivq0000001vg2-att/data_j.xls'

  def download_xls_from_jpx
    file_path = newest_file_name
    open(LISTED_COMPANY_FILE_URL, 'rb') do |read_file|
      open(file_path, 'wb') do |saved_file|
        saved_file.write(read_file.read)
      end
    end
  end

  def exists_newest_file?
    file_path = newest_file_name
    FileTest.exist?(file_path) && FileTest.size(file_path) > 0
  end

  def newest_file_name
    # 毎月10日の9:00以降を当月の最新ファイルとする
    # (毎月第3営業日の午前9時以降に前月末データを掲載します。)
    now = DateTime.now
    threshold = DateTime.new(now.year, now.mon, 10, 9, 0, 0)
    @newest_file_name ||= now.prev_month(now >= threshold ? 1 : 2).strftime("jpx_company_%Y%m.xls")
  end
end
