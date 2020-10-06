class Directory
  def initialize
    load_students
  end

  def load_students(filename = "students.csv")
    students = []
    if File.exists?(filename)
      File.open(filename, "r") do |file|
        file.readlines.each do |line|
          name, cohort = line.chomp.split(",")
          students.push(Student.new(name, cohort))
        end
      end
    end
    @students = students
  end

  def save_students
    puts "Enter filename, or press enter to use default:"
    filename = STDIN.gets.chomp
    if filename == ""
      filename = "students.csv"
    end
    file = File.open(filename, "w")
    @students.each do |student|
      student_data = [student.name, student.cohort]
      csv_line = student_data.join(",")
      file.puts(csv_line)
    end
    file.close
  end

  def input_students
    puts "Please enter the names of the students followed by their cohort"
    puts "To finish, just hit return twice"

    while true do
      name = input_helper("name")
      if name.empty?
        break
      end
      cohort = input_helper("cohort")
      if cohort.empty?
        cohort = :november
      end
      student = Student.new(name, cohort)
      @students << student
      puts "Now we have #{@students.count} #{@students.count == 1 ? "student" : "students"}"
    end
  end

  def input_helper(field)
    puts field.capitalize
    STDIN.gets.chomp
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
        puts "#{index + 1}. #{student.name} (#{student.cohort} cohort)"
      end
    end
  end

  def print_footer
    student_count = @students.count
    puts "Overall, we have #{student_count} great #{student_count == 1 ? "student" : "students"}".center(50)
  end

  def show_students
    print_header
    print_students_list
    print_footer
  end
end
