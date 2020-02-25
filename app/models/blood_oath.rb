class BloodOath

    @@all = []

    attr_reader :cult, :follower, :initiation_date

    def initialize(cult, follower, initiation_date)
        @cult = cult
        @follower = follower
        @initiation_date = initiation_date

        @@all << self
    end

    # --- CLASS METHODS --- #

    # - Required - #

    def self.all
        @@all
    end

    # - Advanced - #

    def self.first_oath
        # Returns the Follower instance for the follower that made the very first blood oath
        self.all.min_by {|blood_oath| blood_oath.initiation_date}.follower
    end

end
