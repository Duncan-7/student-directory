require_relative "directory"
require_relative "student"


class Menu
  def initialize
    @directory = Directory.new
  end

  def show_menu
    loop do
      print_menu
      process(STDIN.gets.chomp)
    end
  end

  def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit"
  end

  def process(selection)
    case selection
    when "1"
      @directory.input_students
    when "2"
      @directory.show_students
    when "3"
      @directory.save_students
    when "4"
      @directory.load_students
    when "9"
      exit
    else
      puts "I didn't understand, please choose again."
    end
  end
end

menu = Menu.new
menu.show_menu
