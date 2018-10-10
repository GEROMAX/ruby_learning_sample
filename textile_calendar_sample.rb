require "date"
require "csv"
require "./lib/schedule_matcher"
require "./lib/calendar_data_builder"
require "./lib/textile_calendar_renderer"

class CalendarDataBuilderSample < CalendarDataBuilder
  def initialize(file_path, start_date, end_date)
    @data_source = CSV.read(file_path, encoding: "Shift_JIS:UTF-8")
    super(start_date, end_date)
  end

  def value_at_date(target_date)
    @data_source.select do |row|
      matcher = ScheduleMatcher.new(row[0])
      matcher.match_date?(target_date) | matcher.match_day_of_week?(target_date.cwday)
    end.sort do |a,b|
      a_time = /(\d+):(\d+)/.match(a[1])[1..2].reduce("") { |result, val| result += val.length > 1 ? val : "0".concat(val) }
      b_time = /(\d+):(\d+)/.match(b[1])[1..2].reduce("") { |result, val| result += val.length > 1 ? val : "0".concat(val) }
      p a_time
      p b_time
      time_cpmpare = a_time <=> b_time
      time_cpmpare.eql?(0) ? a[2] <=> b[2] : time_cpmpare
    end.reduce([]) do |result, row|
      result << row[1..2].join(" ")
    end
  end
  private :value_at_date
end

begin
  return if ARGV.empty?
  souce_csv_path = ARGV[0]

  start_date = Date.new(2018, 10, 1)
  end_date = Date.new(2018, 11, 4)
  calendar_data = CalendarDataBuilderSample.new(souce_csv_path, start_date, end_date).build_data

  # 出力
  renderer = TextileCalendarRenderer.new(calendar_data)
  renderer.render
end
