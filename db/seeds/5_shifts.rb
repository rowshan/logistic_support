tws = TimeWindow.all.map(&:id)
shifts = Plant.all.map do |p|
  [
    {
      name: 'Shift 1', enabled: [true, false].sample,
      start_time: '08:00', end_time: '13:00',
      send_time: %w(07:15 07:30 07:45).sample,
      plant: p
    },
    {
        name: 'Shift 2', enabled: [true, false].sample,
        start_time: '14:00', end_time: '21:00',
        send_time: %w(13:15 13:30 13:45).sample,
        plant: p
    }
  ]
end.flatten

shifts.each {|attrs| Shift.create! attrs }
