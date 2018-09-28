require 'date'

class ScheduleMatcher
  def initialize(data)
    @data = data
    @day_of_weeks = {"月" => 1, "火" => 2, "水" => 3, "木" => 4, "金" => 5, "土" => 6, "日" => 7}
  end

  # like `１日` `13日`
  def match_day?(day)
    find_day = /(?<find_day>^\d+)/.match(@data)
    return false unless find_day
    find_day[:find_day].to_i.eql?(day)
  end

  # like `第1水曜日` `第1第3金曜日`
  def match_ordinal_day_of_week?(date)
    3.times do |i|
      pattern = ""
      (i + 1).times {|j| pattern << '第(\d+)'}
      md = /#{pattern}(.)曜日/.match(@data)
      next unless md

      dow = md[i + 2]
      return false unless @day_of_weeks[dow].eql?(date.cwday)

      ordinals = md[1..(i + 1)]
      return true if ordinals.any? {|ord| ord.to_i.eql? day_of_week_ordinal_at_date(date) }
    end
    false
  end

  # 指定日の曜日が月内の第何X曜日か算出
  # 2018/10/15 = 3(第3月曜)
  def day_of_week_ordinal_at_date(target_date)
    day = target_date.dup
    cnt = 0
    while target_date.month.eql?(day.month)
      cnt += 1
      day -= 7
    end
    cnt
  end
  private :day_of_week_ordinal_at_date

  # like `水曜日` `火曜日～木曜日`
  def match_day_of_week?(cwday)
    match_range = /^(?<find_day1>.)曜日～(?<find_day2>.)曜日/.match(@data)
    if match_range
      day_a = @day_of_weeks[match_range[:find_day1]]
      day_b = @day_of_weeks[match_range[:find_day2]]
      (day_a..day_b) === cwday
    else
      match_day = /(?<find_day_of_week>^.)曜日/.match(@data)
      match_day ? @day_of_weeks[match_day[:find_day_of_week]].eql?(cwday) : false
    end
  end

  # 月末
  def last_day_of_month?(date)
    return false unless /^毎月最終日/ =~ @data
    last_day = Date.new(date.year, date.month, -1)
    last_day.eql?(date)
  end
end