require 'csv'

@students = []

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to a file'
  puts '4. Load the list from a file'
  puts '9. Exit'
end

def interactive_menu
  loop do
    print_menu
    selection = $stdin.gets.chomp
    process(selection)
  end
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    filename = select_file
    save_students(filename)
  when '4'
    filename = select_file
    load_students(filename)
  when '9'
    exit
  else
    puts "I don't know what you meant, try again."
  end
end

def input_students
  puts "Please enter the student names"
  puts "Hit return twice to finish"
  students = []
  name = gets.chomp

  cohort = ""
  while !name.empty? do
    loop do
      puts "What cohort is #{name} in? Type a month."
      cohort = gets.chomp

      case cohort
      when ""
        cohort = "January" # Default when nothing entered
        break
      when "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
        break
      else
        puts "That's not a valid cohort. Please try again."
      end

    end

    process_student(name, cohort)
    @students.count == 1 ? plural = "student" : plural = "students"
    puts "Now we have #{@students.count} #{plural}"
    name = $stdin.gets.chomp
  end
end

def show_students
  print_header
  print_students
  print_footer
end

def select_file
  puts 'Enter a filename,  or press return to use students.csv'
  filename = $stdin.gets.chomp
  filename.empty? ? 'students.csv' : filename
end

def load_students(filename = 'students.csv')
  @students = []
  File.open(filename, 'r') do |file|
    CSV.foreach(file) do |row|
      process_student(row[0], row[1])
    end
  end
  action_feedback("Loaded #{@students.count} from #{filename}")
end

def process_student(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

def save_students(filename = 'students.csv')
  File.open(filename, 'w') do |file|
    @students.each do |student|
      file.puts CSV.generate_line([student[:name], student[:cohort]])
    end
  end
  action_feedback("Student list saved to #{filename}")
end

def try_load_students(filename = ARGV.first)
  filename = ARGV.first
  if filename.nil?
    load_students if File.exist?('students.csv')
  elsif File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def print_header
  puts "The students of Villains Academy".center(75)
  puts "-------------".center(75)
end

def print_students
  cohorts = @students.map { |e| e[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "====#{cohort} cohort====".center(75)
    count = 0
    @students.each do |s|
      if s[:cohort] == cohort
        puts "#{count + 1}. #{s[:name]}"
        count += 1
      end
    end
    puts "\n"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(75)
end

def action_feedback(result)
  puts "\n#{result}\n\n"
end

try_load_students
interactive_menu
