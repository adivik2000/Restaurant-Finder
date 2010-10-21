require 'restaurant'
require 'support/string_extend'

class Guide
  
  def initialize(path=nil)
    # locate the restaurant text file at path
    Restaurant.filepath = path
    
    if Restaurant.file_usable?
      puts "Found restaurant file."
    elsif Restaurant.create_file
      puts "Created restaurant file."
      # exit if create fails
    else
      puts "Exiting.\n\n"
      exit!
    end  
    
    # or create a new file
    # exit if create fails
  end
  
  def launch!
    introduction
    loop do
      # action loop
      #   what do you want to do?
      print "> "
      user_response = gets.chomp
      #   do that action
      result = do_action(user_response)
      # repeat until user quits
      break if result == :quit
    end
    conclusion
  end
  
  def do_action(action) 
    case action
      when 'list'
        list
      when 'find'
        puts 'Finding...'
      when 'add'
        add
      when 'quit'
        return :quit
      else
        puts "\nI don't understand that command.\n"
    end
  end
  
  def introduction
    puts "\n\n<<< Welcome to the Restaurant Locator >>>\n\n"
    puts "This is an interactive guide to help you find the perfect restaurant.\n\n"
  end
  
  def add
    puts "\nAdd a restaurant\n\n".upcase
      if restaurant.save
        puts "\nRestaurant Added\n\n" 
      else
        puts "\nSave Error: Restaurant not added\n\n"
      end               
  end
  
  def list
    output_action_header("Listing Restaurants")
    restaurants = Restaurant.saved_restaurants
    output_restaurant_table(restaurants)
    # puts #{restaurants.size}
    # restaurants.each do |rest|
    #   puts rest.name + " | " + rest.cuisine  + " | " + rest.formatted_price
    # end
  end
  
  def conclusion
    puts "\n<<< Goodbye and Bon Appetit! >>>\n\n\n"
  end

  private

  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end
  
  def output_restaurant_table(restaurants=[])
    print " " + "Name".ljust(30)
    print " " + "Cuisine".ljust(20)    
    print " " + "Price".rjust(6) + "\n"   
    puts "-" * 60
    restaurants.each do |rest|      
      line = " " << rest.name.titleize.ljust(30)
      line << " " + rest.cuisine.titleize.ljust(20)
      line << " " + rest.formatted_price.rjust(6)
      puts line
    end
    puts "No listing found" if restaurants.empty?
    puts "-" * 60  
  end

end