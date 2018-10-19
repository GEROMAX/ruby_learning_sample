require 'spreadsheet'
require './lib/jpx_company_info'

module JPXDataReader
  COL_SECURITIES_CODE = 1
  COL_NAME = 2
  COL_MARKET = 3
  COL_INDUSTRY_CODE_1ST = 4
  COL_INDUSTRY_NAME_1ST = 5
  COL_INDUSTRY_CODE_2ND = 6
  COL_INDUSTRY_NAME_2ND = 7
  COL_STOCK_INDEX_CODE = 8
  COL_STOCK_INDEX_NAME = 9

  def data_read_from_file(file_path)
    book = Spreadsheet.open(file_path)
    sheet = book.worksheet(0)
    lst = []
    header = nil
    sheet.each do |row|
      next unless header ||= true

      lci = JPXCompanyInfo.new
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
