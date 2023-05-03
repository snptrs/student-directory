def input_students
  puts "Please enter the student names"
  puts "Hit return twice to finish"
  students = []
  name = gets.chomp

  while !name.empty? do
    puts "What's #{name}'s favourite hobby?"
    hobby = gets.chomp
    students << {name: name, cohort: :november, hobby: hobby}
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
  count = 0
  while count < students.length
      puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort), whose favourite hobby is #{students[count][:hobby]}".center(75)
      count += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(75)
end

students = input_students
print_header
print(students)
print_footer(students)