#########
# Seeds for showing courses / student attendance over time
# Related to the 'responses' seeds in the `survey` app
#########

options_hash = {col_sep: ",", headers: true,
  header_converters: :symbol, converters: :numeric}

teachers = CSV.open('./db/data/teachers.csv', options_hash)
students = CSV.open('./db/data/students.csv', options_hash)
courses = CSV.open('./db/data/courses.csv', options_hash)

teachers_ar = {}; students_ar = {}; courses_ar = {}
to_save = [ {model:Teacher, csv:teachers, collector:teachers_ar},
            {model:Student, csv:students, collector:students_ar},
            {model:Course, csv:courses, collector:courses_ar}]

to_save.each do |options|
  options[:csv].each do |row|
    ar = options[:model].create!(row.to_hash)
    options[:collector][ar.id.to_s] = ar
  end
end

student_courses = CSV.open('./db/data/student_courses.csv', options_hash)
student_courses.each do |row|
  hash = row.to_hash
  s_id = hash[:student_id].to_s
  c_id = hash[:course_id].to_s
  students_ar[s_id].courses << courses_ar[c_id]
end

teacher_courses = CSV.open('./db/data/teacher_courses.csv', options_hash)
teacher_courses.each do |row|
  hash = row.to_hash
  t_id = hash[:teacher_id].to_s
  c_id = hash[:course_id].to_s
  courses_ar[c_id].teachers << teachers_ar[t_id]
end

attendances = CSV.open('./db/data/attendances.csv', options_hash)

attendances.each do |row|
  hash = row.to_hash
  course = courses_ar[hash[:course_id].to_s]
  student = students_ar[hash[:student_id].to_s]
  creation = hash[:days_ago].days.ago
  Attendance.create!(
    course: course, student: student,
    attendance: hash[:attendance],
    created_at: creation, updated_at: creation
    )
end

##############
# These seeds are for demonstrating the live-updating attendance
##############

will1= Student.create(id: Student.count + 1, first_name: "William", last_name: "Peterson", student_id: "250923", google_id: "107113987859408235003")
will2 = Student.create(id: Student.count + 1, first_name: "wpgp", last_name: "Peterson", student_id: "4441", google_id: "123456")
blake = Student.create(id: Student.count + 1, first_name: "Blake", last_name: "Enyart", student_id: "5497", google_id: "1234567")
carrie = Student.create(id: Student.count + 1, first_name: "Carrie", last_name: "Walsh", student_id: "2233", google_id: "1234568")
jennica = Student.create(id: Student.count + 1, first_name: "Jennica", last_name: "Stiehl", student_id: "5928", google_id: "1234569")
trevor = Student.create(id: Student.count + 1, first_name: "Trevor", last_name: "Nodland", student_id: "1022", google_id: "1234560")

simple_teacher = Teacher.create(id: Teacher.count + 1, first_name: "Sam", last_name: "Johnson", email: "example@mail.com", password: "password", role: 2)

s_course = simple_teacher.courses.create(id: Course.count + 1, name: "Calculus", period: "1", start_time: "0:00:00", end_time: "23:59:59")
s_course2 = simple_teacher.courses.create(id: Course.count + 1, name: "English IV", period: "2", start_time: "0:00:00", end_time: "23:59:59")
s_course3 = simple_teacher.courses.create(id: Course.count + 1, name: "Philosophy", period: "3", start_time: "0:00:00", end_time: "23:59:59")
s_course4 = simple_teacher.courses.create(id: Course.count + 1, name: "History", period: "4", start_time: "0:00:00", end_time: "23:59:59")
s_course5 = simple_teacher.courses.create(id: Course.count + 1, name: "Computer Science", period: "5", start_time: "0:00:00", end_time: "23:59:59")

[will1, will2, blake, carrie, jennica, trevor].each do |student|
  [s_course, s_course2, s_course3, s_course4, s_course5]. each do |course|
    student.courses << course
    student.attendances.create(course: course, attendance: nil)
  end
end

Code.create(course:s_course, code:"abcd")
Code.create(course:s_course2, code:"abcd2")
Code.create(course:s_course3, code:"abcd3")
Code.create(course:s_course4, code:"abcd4")
Code.create(course:s_course5, code:"abcd5")

##############
# These Seeds are for demonstrating counselor stuff
##############

c1 = Teacher.create(id: Teacher.count + 1, role: 1, first_name: "Judy", last_name: "Judge", email: "jjudge@comsenz.com", password: "password")
c2 = Teacher.create(id: Teacher.count + 1, role: 1, first_name: "John", last_name: "McMann", email: "jmcmann@comsenz.com", password: "password")
c3 = Teacher.create(id: Teacher.count + 1, role: 1, first_name: "Sally", last_name: "James", email: "Sally@comsenz.com", password: "password")
c4 = Teacher.create(id: Teacher.count + 1, role: 1, first_name: "Sarah", last_name: "Smith", email: "sarahsmith@comsenz.com", password: "password")
c5 = Teacher.create(id: Teacher.count + 1, role: 1, first_name: "Steven", last_name: "Hendricks", email: "stevenh@comsenz.com", password: "password")

##########
##########
# NOTE, it will be much better on the attendance side of things
# to not need to create courses for the counselling
##########
##########

# c91 = c1.courses.create(name: "Counseling 9th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c92 = c1.courses.create(name: "Counseling 10th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c93 = c2.courses.create(name: "Counseling 10th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c94 = c3.courses.create(name: "Counseling 11th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c95 = c4.courses.create(name: "Counseling 12th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c96 = c5.courses.create(name: "Counseling 9th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c97 = c5.courses.create(name: "Counseling 10th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
# c98 = c5.courses.create(name: "Counseling 11th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")

#########
# These seeds are for demonstrating strageties stuff
# Set seeds on random generators to create consistent data
#########
rng = Random.new(42)
Faker::Config.random = Random.new(1738)

teacher_keys = teachers_ar.keys
students_ar.each do |id, student|
  rng.rand(5).times do
    length = 1 + rng.rand(15)
    teacher_id = teacher_keys.shuffle.first
    student.strategies.create(
      teacher: teachers_ar[teacher_id],
      strategy: Faker::Lorem.sentence(10)
      )
  end
end

StrategyReference.create(built_in: "Graphic Organizers")
StrategyReference.create(built_in: "Fidget Toy")
StrategyReference.create(built_in: "Classroom Job")
StrategyReference.create(built_in: "Kinesthetic Learner")
StrategyReference.create(built_in: "Team Facilitator")
StrategyReference.create(built_in: "Music with Headphones")
StrategyReference.create(built_in: "Quiet Space")
StrategyReference.create(built_in: "Verbal Assessments")
