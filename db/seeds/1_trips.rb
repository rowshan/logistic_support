tks = TripKind.all.map(&:id)

trips = (1..10).to_a.collect do |i|
  {
      order_id: SecureRandom.uuid, date: Date.today, trip_kind_id: tks.sample,
      start_time: "#{(8..20).to_a.sample}:#{['00','15','30','45'].sample}" ,
      end_time: "#{(8..20).to_a.sample}:#{['00','15','30','45'].sample}"
  }
end

trips.each {|attrs| Trip.create!(attrs)}
