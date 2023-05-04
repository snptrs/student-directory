@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    filename = select_file
    save_students(filename)
  when "4"
    filename = select_file
    load_students(filename)
  when "9"
    exit
  else
    puts "I don't know what you meant, try again."
  end
end

def select_file
  puts "Enter a filename,  or press return to use students.csv"
  filename = STDIN.gets.chomp
  filename.empty? ? "students.csv" : filename
end

def show_students
  print_header
  print_students
  print_footer
end

def input_students
  puts "Please enter the student names"
  puts "Hit return twice to finish"
  name = STDIN.gets.chomp

  while !name.empty? do
    process_student(name, :november)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def load_students(filename = "students.csv")
  @students = []
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    process_student(name, cohort)
  end
  file.close
  action_feedback("Loaded #{@students.count} from #{filename}")
end

def process_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def save_students(filename = "students.csv")
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  action_feedback("Student list saved to #{filename}")
end

def try_load_students(filename = ARGV.first)
  filename = ARGV.first
  if filename.nil?
    load_students if File.exist?("students.csv")
  elsif File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students
  @students.each_with_index do |student, i|
      puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def interactive_menu
  loop do
    print_menu
    selection = STDIN.gets.chomp
    process(selection)
  end
end

def action_feedback(result)
  puts "\n#{result}\n\n"
end

try_load_students
interactive_menu
