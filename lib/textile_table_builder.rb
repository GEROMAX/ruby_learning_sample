class TextileTableBuilder
  attr_accessor :line_feed_code, :sorted_keys

  def initialize(data_source, options = {})
    @data_source = data_source
    @line_feed_code = options[:line_feed_code] ||= "\n"
    @sorted_keys = options[:sorted_keys] ||= @data_source.keys.sort {|a,b| a <=> b}
  end

  def to_table
    [create_header].concat(create_rows).join(@line_feed_code)
  end

  def create_header
    sorted_keys.reduce("|") {|textile, column_name| textile << "_. #{column_name} |" }
  end
  private :create_header

  def create_rows
    rows = []
    max_row_count = @data_source.values.max.length
    max_row_count.times do |idx|
      textile = "|"
      sorted_keys.each do |key|
        textile << "^. #{@data_source[key][idx]} |"
      end
      rows << textile
    end
    rows
  end
  private :create_rows
end
