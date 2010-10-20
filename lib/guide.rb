require 'restaurant'

class Guide
  
  class Config
    @@actions = ['list', 'find', 'add', 'quit']
    def self.actions; @@actions; end
  end
  
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
      action = get_action
      result = do_action(action)
      # repeat until user quits
      break if result == :quit
    end
    conclusion
  end
  
  def get_action
    action = nil
    until Guide::Config.actions.include?(action)
      puts "Available actions " +  Guide::Config.actions.join(", ") if action
      print "> "
      user_response = gets.chomp    
      action = user_response.downcase.strip
    end
    return action
  end
  
  def do_action(action)
    case action
      when 'list'
        puts 'Listing...'
      when 'find'
        puts 'Finding...'
      when 'add'
        puts 'Adding...'
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
  
  def conclusion
    puts "\n<<< Goodbye and Bon Appetit! >>>\n\n\n"
  end
  
end