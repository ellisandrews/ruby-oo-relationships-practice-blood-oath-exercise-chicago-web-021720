require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end

# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console

# --- SETUP --- #

# Make 3 cults
cult_vikings = Cult.new('Vikings', 'Minneapolis, MN', 2018, 'Skol Vikings!', 50)
cult_bears = Cult.new('Bears', 'Chicago, IL', 2019, 'Da Bears!', 40)
cult_packers = Cult.new('Packers', 'Green Bay, WI', 2020, 'Go Pack Go!', 30)

# Create and add some single-cult followers to each cult
vikings_followers = []
3.times { |i| vikings_followers << Follower.new("Vikings Fan #{i}", 60-i, "Vikings #{i}") }

bears_followers = []
2.times { |i| bears_followers << Follower.new("Bears Fan #{i}", 50-i, "Bears #{i}") }

packers_followers = []
1.times { |i| packers_followers << Follower.new("Packers Fan #{i}", 40-i, "Packers #{i}") }

# Create some multi-cult followers
follower_nfl = Follower.new("NFL Fan 1", 90, "NFL 1")
follower_anti_packers = Follower.new("Anti Packers Fan 1", 80, "Anti Packers 1")

# Add multi-cult followers to multiple cults
vikings_followers << follower_nfl
bears_followers << follower_nfl
packers_followers << follower_nfl

vikings_followers << follower_anti_packers
bears_followers << follower_anti_packers


# --- METHOD TESTING --- #

# - Cult - #

# required # 

# Cult#recruit_follower / Cult#cult_population

# Recruit some valid followers
vikings_followers.each { |vikings_follower| cult_vikings.recruit_follower(vikings_follower) }
bears_followers.each { |bears_follower| cult_bears.recruit_follower(bears_follower) }
packers_followers.each { |packers_follower| cult_packers.recruit_follower(packers_follower) }

# Try to recruit some invalid followers (too young)
cult_vikings.recruit_follower(Follower.new("Vikings Fan Invalid", 45, "Vikings Invalid"))
cult_bears.recruit_follower(Follower.new("Bears Fan Invalid", 35, "Bears Invalid"))

puts "\n\tCult#recruit_follower / Cult#cult_population"
puts "cult_vikings.cult_population (5) => #{cult_vikings.cult_population}"
puts "cult_bears.cult_population (4) => #{cult_bears.cult_population}"
puts "cult_packers.cult_population (2) => #{cult_packers.cult_population}"

# # Cult#blood_oaths / Cult#followers
puts "\n\tCult#blood_oaths / Cult#followers"
puts "cult_vikings.followers => #{cult_vikings.followers}"
puts "cult_bears.followers => #{cult_bears.followers}"
puts "cult_packers.followers => #{cult_packers.followers}"

# Cult.find_by_name
puts "\n\tCult.find_by_name"
puts "Cult.find_by_name('Vikings').name => #{Cult.find_by_name('Vikings').name}"
puts "Cult.find_by_name('Bears').name => #{Cult.find_by_name('Bears').name}"
puts "Cult.find_by_name('Packers').name => #{Cult.find_by_name('Packers').name}"

# Cult.find_by_location
puts "\n\tCult.find_by_location"
puts "Cult.find_by_location('Minneapolis, MN')[0].name (Vikings) => #{Cult.find_by_location('Minneapolis, MN')[0].name}"
puts "Cult.find_by_location('Chicago, IL')[0].name (Bears) => #{Cult.find_by_location('Chicago, IL')[0].name}"
puts "Cult.find_by_location('Green Bay, WI')[0].name (Packers) => #{Cult.find_by_location('Green Bay, WI')[0].name}"

# Cult.find_by_founding_year
puts "\n\tCult.find_by_founding_year"
puts "Cult.find_by_founding_year(2018)[0].name (Vikings) => #{Cult.find_by_founding_year(2018)[0].name}"
puts "Cult.find_by_founding_year(2019)[0].name (Bears) => #{Cult.find_by_founding_year(2019)[0].name}"
puts "Cult.find_by_founding_year(2020)[0].name (Packers) => #{Cult.find_by_founding_year(2020)[0].name}"

# advanced #

# Cult#average_age
puts "\n\tCult#average_age"
puts "cult_vikings.average_age (69.4) => #{cult_vikings.average_age}"

# Cult#my_followers_mottos
puts "\n\tCult#my_followers_mottos"
puts "cult_vikings.my_followers_mottos =>" 
cult_vikings.my_followers_mottos

# Cult.least_popular
puts "\n\tCult.least_popular"
puts "Cult.least_popular.name (Packers) => #{Cult.least_popular.name}"

# Cult.most_common_location
puts "\n\tCult.most_common_location"
cult_bears_2 = Cult.new('Bears 2', 'Chicago, IL', 2021, 'Da Bears 2!', 40)
puts "Cult.most_common_location (Chicago, IL)=> #{Cult.most_common_location}"


# - Follower - #

# required #

follower_vikings = vikings_followers[0]
follower_bears = bears_followers[0]
follower_packers = packers_followers[0]

# Follower#cults / Follower#blood_oaths
puts "\n\tFollwer#cults"
puts "follower_vikings.cults => #{follower_vikings.cults}"
puts "follower_bears.cults => #{follower_bears.cults}"
puts "follower_packers.cults => #{follower_packers.cults}"
puts "follower_nfl.cults => #{follower_nfl.cults}"
puts "follower_anti_packers.cults => #{follower_anti_packers.cults}"

# Follower#join_cult
puts "\n\tFollower#join_cult"

# Add a valid cult follower
follower_packers_new = Follower.new("Packers Fan New", 91, "Packers New")
follower_packers_new.join_cult(cult_packers, initiation_date='2019-02-24')

# Try to add an invalid cult follower
follower_packers_invalid = Follower.new("Packers Fan Invalid", 25, "Packers Invalid")
follower_packers_invalid.join_cult(cult_packers, initiation_date='2019-02-24')

puts "follower_packers_new.cults => #{follower_packers_new.cults}"

# Follower.of_a_certain_age
puts "\n\tFollower.of_a_certain_age"
puts "Follower.of_a_certain_age(51) => #{Follower.of_a_certain_age(51)}"

# advanced #

# Follower#my_cults_slogans
puts "\n\tFollower#my_cults_slogans"
puts "follower_anti_packers.my_cults_slogans =>" 
follower_anti_packers.my_cults_slogans

# Follower.most_active
puts "\n\tFollower.most_active"
puts "Follower.most_active.name (NFL Fan 1) => #{Follower.most_active.name}"

# Follower.top_ten
puts "\n\tFollower.top_ten"
puts "Follower.top_ten.map { |follower| follower.name } => #{Follower.top_ten.map { |follower| follower.name }}"

# bonus #

# Follower#fellow_cult_members
puts "\n\tFollower#fellow_cult_members"
puts "follower_vikings.fellow_cult_members => #{follower_vikings.fellow_cult_members}"


# - BloodOath - #

# BloodOath.first_oath
puts "\n\tBloodOath.first_oath"
puts "BloodOath.first_oath.name (Packers Fan New) => #{BloodOath.first_oath.name}"


# binding.pry