time_windows = (8..21).to_a.collect do |st|
  {
      tenant_id: '08a6f136-c9ea-4174-90ca-9d9865ed4314',
      start_time: "#{st}:00", end_time: "#{st+1}:00",
      label: "#{st}:00 - #{st+1}:00"
  }
end

time_windows.each {|attrs| TimeWindow.create! attrs}
