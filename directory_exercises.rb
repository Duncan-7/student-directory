# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :june},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :july},
#   {name: "Alex DeLarge", cohort: :november},
#   {name: "The Wicked Witch of the West", cohort: :november},
#   {name: "Terminator", cohort: :november},
#   {name: "Freddy Krueger", cohort: :december},
#   {name: "The Joker", cohort: :november},
#   {name: "Joffrey Baratheon", cohort: :november},
#   {name: "Norman Bates", cohort: :november}
# ]
@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I didn't understand, please choose again."
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students
  puts "Please enter the names of the students followed by their cohort"
  puts "To finish, just hit return twice"

  while true do
    puts "Name:"
    name = STDIN.gets.chomp
    p name
    if name.empty?
      break
    end
    cohort = :november
    puts "Cohort:"
    cohort = STDIN.gets.chomp
    if cohort.empty?
      cohort = :november
    end
    @students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{@students.count} #{@students.count == 1 ? "student" : "students"}"
  end
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_students_list
  if @students.count == 0
    puts "No students enrolled yet.".center(50)
  else
    @students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_by_cohort
  list_of_cohorts = []
  @students.each do |student|
    unless list_of_cohorts.include? student[:cohort]
      list_of_cohorts << student[:cohort]
    end
  end
  list_of_cohorts.each do |cohort|
    puts cohort.to_s + ":"
    @students.each do |student|
      if student[:cohort] == cohort
        puts student[:name]
      end
    end
  end
end

# def print(students)
#   iterator = 0
#   while iterator < students.length
#     puts "#{iterator + 1}. #{students[iterator][:name]} (#{students[iterator][:cohort]} cohort)"
#     iterator += 1
#   end
# end

def print_footer
  student_count = @students.count
  puts "Overall, we have #{student_count} great #{student_count == 1 ? "student" : "students"}".center(50)
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts(csv_line)
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students.push({name: name, cohort: cohort.to_sym})
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
