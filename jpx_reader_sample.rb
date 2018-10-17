require 'date'
require 'open-uri'
require 'spreadsheet'
require 'logger'

e_logger = Logger.new(STDERR)
i_logger = Logger.new(STDOUT)

module JPXCrawlHelper
  LISTED_COMPANY_FILE_URL = 'http://www.jpx.co.jp/markets/statistics-equities/misc/tvdivq0000001vg2-att/data_j.xls'
  module_function

  def get_listed_company_file
    file_path = get_newest_file_name
    return file_path if FileTest.exist?(file_path) && FileTest.size(file_path) > 0

    # 最新ファイルがなければJPXから取得
    open(LISTED_COMPANY_FILE_URL, 'rb') do |read_file|
      open(file_path, 'wb') do |saved_file|
        saved_file.write(read_file.read)
      end
    end
    file_path
  end

  def get_newest_file_name
    # 毎月10日の9:00以降を当月の最新ファイルとする
    # (毎月第3営業日の午前9時以降に前月末データを掲載します。)
    now = DateTime.now
    threshold = DateTime.new(now.year, now.mon, 10, 9, 0, 0)
    now.prev_month(now >= threshold ? 1 : 2).strftime("jpx_listed_company_%Y%m.xls")
  end
end

class ListedCompanyInfo
  attr_accessor :securities_code,
                :name,
                :other_names,
                :market,
                :industry_code_1st,
                :industry_name_1st,
                :industry_code_2nd,
                :industry_name_2nd,
                :stock_index_code,
                :stock_index_name
end

class JPXFileReader
  COL_SECURITIES_CODE = 1
  COL_NAME = 2
  COL_MARKET = 3
  COL_INDUSTRY_CODE_1ST = 4
  COL_INDUSTRY_NAME_1ST = 5
  COL_INDUSTRY_CODE_2ND = 6
  COL_INDUSTRY_NAME_2ND = 7
  COL_STOCK_INDEX_CODE = 8
  COL_STOCK_INDEX_NAME = 9
  attr_accessor :file_path

  def initialize(path)
    @file_path = path
  end

  def create_listed_company_infos
    book = Spreadsheet.open(@file_path)
    sheet = book.worksheet(0)
    lst = []
    header = nil
    sheet.each do |row|
      next unless header ||= true

      lci = ListedCompanyInfo.new
      lci.securities_code = row[COL_SECURITIES_CODE].to_i
      lci.name = row[COL_NAME]
      lci.market = row[COL_MARKET]
      lci.industry_code_1st = row[COL_INDUSTRY_CODE_1ST].to_i
      lci.industry_name_1st = row[COL_INDUSTRY_NAME_1ST]
      lci.industry_code_2nd = row[COL_INDUSTRY_CODE_2ND].to_i
      lci.industry_name_2nd = row[COL_INDUSTRY_NAME_2ND]
      lci.stock_index_code = row[COL_STOCK_INDEX_CODE].to_i
      lci.stock_index_name = row[COL_STOCK_INDEX_NAME]
      lst << lci
    end
    lst
  end
end

########################################################################################################################
begin
  infos = JPXFileReader.new(JPXCrawlHelper.get_listed_company_file).create_listed_company_infos
  puts infos.inspect
end
