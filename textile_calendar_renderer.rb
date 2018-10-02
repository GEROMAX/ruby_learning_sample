require './textile_table_builder'

class TextileCalendarRenderer
  attr_reader :calendar, :line_feed_code

  def initialize(calendar, options = {})
    @calendar = calendar
    @line_feed_code = options[:line_feed_code] ||= "\n"
  end

  def render
    day_of_weeks = {"月" => 1, "火" => 2, "水" => 3, "木" => 4, "金" => 5, "土" => 6, "日" => 7}
    table_data = day_of_weeks.keys.reduce({}) { |result, key| result.merge(key => []) }

    days = @calendar.keys.sort{|a, b|a <=> b}
    offset = 0
    while offset <= days.length
      days[offset..(offset + 6)].each do |key_day|
        week_key = day_of_weeks.select {|k,v| v.eql?(key_day.cwday)}.keys[0]
        target_box = table_data[week_key]
        target_box << @calendar[key_day].reduce("#{key_day.month}/#{key_day.day}#{@line_feed_code}　") do |result, batch_info|
          result << "#{@line_feed_code}#{batch_info}"
        end
      end
      offset += 7
    end

    builder = TextileTableBuilder.new(table_data, sorted_keys: ["月", "火", "水", "木", "金", "土", "日"], line_feed_code: @line_feed_code)
    puts builder.to_table
  end
end