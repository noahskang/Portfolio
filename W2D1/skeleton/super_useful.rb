# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError => error
  return error
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  FRUITS.include? maybe_fruit

  puts "OMG, thanks so much for the #{maybe_fruit}!"
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp

  raise ArgumentError unless FRUITS.include? maybe_fruit
  rescue
    puts "I need coffee!"
    retry if maybe_fruit == "coffee"
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    raise ArgumentError.new("We are not real friends") if yrs_known < 5
    @fav_pastime = fav_pastime

    raise ArgumentError.new("Enter sth") if @name.empty? || @fav_pastime.empty?
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
