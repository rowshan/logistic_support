ps = Plant.all.map(&:id)
drivers = (0..20).to_a.collect do |i|
  {
      plant_id: ps.sample, user_id: SecureRandom.uuid,
      first_name: SecureRandom.hex, last_name: SecureRandom.hex,
      phone_no: (1..13).to_a.map{ rand(0..9) }.join,
  }
end

drivers.each{|attrs| Driver.create! attrs }
