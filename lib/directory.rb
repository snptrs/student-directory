def input_students
  puts "Please enter the student names"
  puts "Hit return twice to finish"
  students = []
  name = gets.chomp

  cohort = "" # Su
  while !name.empty? do
    loop do
      puts "What cohort is #{name} in? Type: January, February, March or April"
      cohort = gets.chomp

      case cohort
      when ""
        cohort = "January" # Default when nothing entered
        break
      when "January", "February", "March", "April"
        break
      else
        puts "That's not a valid cohort. Please try again."
      end

    end

    puts "What's #{name}'s favourite hobby?"
    hobby = gets.chomp

    students << {name: name, cohort: cohort, hobby: hobby}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end

  students
end

def print_header
  puts "The students of Villains Academy".center(75)
  puts "-------------".center(75)
end

def print(students)
  cohorts = students.map { |e| e[:cohort] }.uniq
  cohorts.each do |cohort|
    puts "====#{cohort} cohort====".center(75)
    count = 0
    students.each do |s|
      if s[:cohort] == cohort
        puts "#{count + 1}. #{s[:name]}, "\
            "whose favourite hobby is #{s[:hobby]}".center(75)
        count += 1
      end
    end
    puts "\n"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(75)
end

students = input_students
print_header
print(students)
print_footer(students)