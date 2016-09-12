tws = TimeWindow.all
Shift.all.each do |s|
  tws.select {|tw| tw.start_time > s.start_time && tw.start_time < s.end_time }.each do |tw|
    ShiftTimeWindow.create! shift: s, time_window: tw
  end
end
