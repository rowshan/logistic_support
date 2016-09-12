plants = (1..3).to_a.collect do |i|
  {
      tenant_id: '08a6f136-c9ea-4174-90ca-9d9865ed4314',
      company: SecureRandom.hex(32),
      email: "#{SecureRandom.hex}@test.com",
      phone_no: (1..13).to_a.map{ rand(0..9) }.join,
      address: "Sample Street, Nr. #{i}",
  }
end

plants.each {|attrs| Plant.create! attrs }
