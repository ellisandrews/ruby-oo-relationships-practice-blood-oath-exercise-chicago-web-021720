require_relative 'blood_oath'


class Cult

    @@all = []

    attr_reader :name, :location, :founding_year, :slogan, :minimum_age

    def initialize(name, location, founding_year, slogan, minimum_age)
        @name = name
        @location = location
        @founding_year = founding_year
        @slogan = slogan
        @minimum_age = minimum_age

        @@all << self
    end

    # --- INTSTNACE METHODS --- #

    # - Required - #

    def recruit_follower(follower, initiation_date='2020-02-24')
        # Takes in an argument of a Follower instance and adds them to this cult's list of followers if they are of age
        if follower.age >= minimum_age
            BloodOath.new(self, follower, initiation_date)
        else
            puts "Sorry, you must be at least #{minimum_age} to join this cult."
        end
    end

    def cult_population
        # Returns an Integer that is the number of followers in this cult
        BloodOath.all.count {|blood_oath| blood_oath.cult == self}
    end

    # - Advanced - #

    def average_age
        # Returns a Float that is the average age of this cult's followers
        age_total = followers.reduce(0) {|total, follower| total + follower.age}
        age_total.to_f / followers.length
    end

    def my_followers_mottos
        # Prints out all of the mottos for this cult's followers
        followers.each {|follower| puts follower.life_motto}
    end

    # - Bonus - #


    # - Custom - #

    def blood_oaths
        # Returns an array of all this cult's BloodOaths
        BloodOath.all.select {|blood_oath| blood_oath.cult == self}
    end

    def followers
        # Returns an arry of all this cult's Followers
        blood_oaths.map {|blood_oath| blood_oath.follower}
    end

    # --- CLASS METHODS --- #

    # - Required - #

    def self.find_by_name(cult_name)
        # Takes a String argument that is a name and returns a Cult instance whose name matches that argument
        self.all.find {|cult| cult.name == cult_name}
    end

    def self.find_by_location(cult_location)
        # Takes a String argument that is a location and returns an Array of cults that are in that location
        self.all.select {|cult| cult.location == cult_location}
    end

    def self.find_by_founding_year(cult_founding_year)
        # Takes an Integer argument that is a year and returns all of the cults founded in that year
        self.all.select {|cult| cult.founding_year == cult_founding_year}
    end

    def self.all
        @@all
    end

    # - Advanced - #

    def self.least_popular
        # Returns the Cult instance who has the least number of followers
        self.all.min_by {|cult| cult.followers.length}
    end

    def self.most_common_location
        # Returns a String that is the location with the most cults
        self.cults_by_location.max_by {|location, cults| cults.length}[0]
    end

    # - Custom - #

    def self.cults_by_location
        # Aggregate cults by location e.g. {"Location 1" => [Cult1, Cult2], ... }
        self.all.group_by {|cult| cult.location}
    end

end
