trip_kinds = [
    { name: 'Pickup', description: 'Pickup Trip' },
    { name: 'Delivery', description: 'Delivery Trip' },
    { name: 'Retoure Pickup', description: 'Retoure Pickup Trip' },
    { name: 'Retoure Delivery', description: 'Retoure Delivery Trip' },
    { name: 'Special Delivery', description: 'Special Delivery' }
]

trip_kinds.each {|attrs| TripKind.create! attrs }
