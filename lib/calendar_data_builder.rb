class CalendarDataBuilder
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def build_data
    calendar_data = {}
    now_date = @start_date
    while now_date <= @end_date
      calendar_data[now_date] = value_at_date(now_date)
      now_date += 1
    end
    calendar_data
  end

  def value_at_date(target_date)
    raise "must implement!"
  end
  private :value_at_date
end