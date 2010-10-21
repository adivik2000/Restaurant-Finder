require 'restaurant'

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
    restaurant = Restaurant.build_using_questions  
      if restaurant.save
        puts "\nRestaurant Added\n\n" 
      else
        puts "\nSave Error: Restaurant not added\n\n"
      end               
  end
  
  def list
    puts "Listing restaurants\n\n".upcase
    restaurants = Restaurant.saved_restaurants
    puts #{restaurants.size}
    restaurants.each do |rest|
      puts rest.name + " | " + rest.cuisine  + " | " + rest.price
    end
  end
  
  def conclusion
    puts "\n<<< Goodbye and Bon Appetit! >>>\n\n\n"
  end
  
end