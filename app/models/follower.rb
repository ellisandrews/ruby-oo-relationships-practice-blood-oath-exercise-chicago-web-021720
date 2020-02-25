require 'set'
require_relative 'blood_oath'


class Follower
    
    @@all = []

    attr_reader :name, :age, :life_motto

    def initialize(name, age, life_motto)
        @name = name
        @age = age
        @life_motto = life_motto
        
        @@all << self
    end

    # --- INSTANCE METHODS --- #

    # - Required - #

    def cults
        # Returns an Array of this follower's cults
        blood_oaths.map {|blood_oath| blood_oath.cult}
    end

    def join_cult(cult, initiation_date='2020-02-24')
        # Takes in an argument of a Cult instance and adds this follower to the cult's list of followers if they are of age
        if age >= cult.minimum_age
            BloodOath.new(cult, self, initiation_date)
        else
            puts "Sorry, you must be at least #{cult.minimum_age} to join this cult."
        end
    end

    # - Advanced - #

    def my_cults_slogans
        # Prints out all of the slogans for this follower's cults
        cults.each {|cult| puts cult.slogan}
    end

    # - Bonus - #

    def fellow_cult_members
        # Returns a unique Array of followers who are in the same cults as you
        
        # Get the followers in those cults (excluding me)
        fellow_followers = Set.new()

        # For each cult I'm in...
        cults.each do |cult|
            # For each follower in the cult...
            cult.followers.each do |follower|
                # If the follower isn't me, add it to my fellow followers
                unless follower == self
                    fellow_followers.add(follower)
                end
            end
        end

        fellow_followers.to_a
    end

    # - Custom - #

    def blood_oaths
        # Returns an Array of all this follower's BloodOaths
        BloodOath.all.select {|blood_oath| blood_oath.follower == self}
    end

    # --- CLASS METHODS --- #

    # - Required - #

    def self.of_a_certain_age(min_follwer_age)
        # Takes an Integer argument that is an age and returns an Array of followers who are the given age or older
        self.all.select {|follower| follower.age >= min_follwer_age}
    end

    def self.all
        @@all
    end

    # - Advanced - #

    def self.most_active
        # Returns the Follower instance who has joined the most cults
        self.all.max_by { |follower| follower.cults.length }
    end

    def self.top_ten
        # Returns an Array of followers; they are the ten most active followers
        self.all.sort_by { |follower| follower.cults.length * -1 }.first(10)
    end

end