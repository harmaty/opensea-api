# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ports = Port.create([
                        {
                            "title" => "Dingle Harbour",
                            "lat" => 52.13333333,
                            "lng" => -10.26666667
                        },
                        {
                            "title" => "Hirao",
                            "lat" => 33.9,
                            "lng" => 132.05
                        },
                        {
                            "title" => "Humbug Point Wharf",
                            "lat" => -12.66666667,
                            "lng" => 141.8666667
                        },
                        {
                            "title" => "Benghazi",
                            "lat" => 32.1166,
                            "lng" => 20.0833
                        },
                        {
                            "title" => "Seaham",
                            "lat" => 54.8333,
                            "lng" => -1.3166
                        },
                        {
                            "title" => "Blue Beach Harbour",
                            "lat" => 48.78333333,
                            "lng" => -58.78333333
                        },
                        {
                            "title" => "Skamania County",
                            "lat" => 45.68333333,
                            "lng" => -121.8833333
                        },
                        {
                            "title" => "Puerto de Calpe",
                            "lat" => 0.0,
                            "lng" => -0.3333333333
                        }
                    ])

capacities = [20, 20.5, 50, 51, 99, 100, 101.3]
dates = (Date.current..(Date.current + 10.days)).to_a

1.upto(1000) do |i|
  position = Position.create position_type: 'Cargo', title: "Cargo #{i}", hold_capacity: capacities.sample
  Opening.create opening_date: dates.sample, position: position, port: ports.sample
end

1.upto(1000) do |i|
  position = Position.create position_type: 'Ship', title: "Ship #{i}", hold_capacity: capacities.sample
  dates.sample(3).each do |date|
    Opening.create opening_date: date, position: position, port: ports.sample
  end
end
