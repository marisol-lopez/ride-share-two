require 'csv'
require 'ap'

module RideShare
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating
    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
      raise ArgumentError.new("Rating must be between 1 and 5") unless @rating >= 1 && @rating <= 5
    end

    def self.all
      @trips = []
      CSV.foreach("./support/trips.csv", {:headers => true}).each do |line|
        @trips << self.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3].to_s, line[4].to_i)
      end
      return @trips
    end

    def self.find_trips_of_driver(id)
      trip_find = RideShare::Trip.all
      array_of_trips = []
      trip_find.each do |trip|
        if trip.driver_id == id
          array_of_trips << trip
        end
      end

      if array_of_trips.length == 0
        raise ArgumentError.new "Sorry, there is no trip with an ID:#{id}."
      else
        return array_of_trips
      end
    end

    def self.find_trips_of_rider(id)
      rider_find = RideShare::Trip.all
      array_of_riders = []
      rider_find.each do |rider|
        if rider.rider_id == id
          array_of_riders << rider
        end
      end
      if array_of_riders.length == 0
        raise ArgumentError.new "Sorry, there is no rider with an ID:#{id}."
      end
      return array_of_riders
    end

  end
end


# puts "retrieve all trips from the CSV file"
# ap RideShare::Trip.all

# puts "find all trip instances for a given driver ID"
# ap RideShare::Trip.find_trips_of_driver(2)

# puts "checking to see if array is empty, meaning the id given did not match any of the drivers"
# ap RideShare::Trip.find_trips_of_driver(998)

# puts "find all trip instances for a given rider ID"
# ap RideShare::Trip.find_trips_of_rider(12)

# puts "checking to see if array is empty, meaning the id given did not match any of the riders"
# ap RideShare::Trip.find_trips_of_rider(999)
