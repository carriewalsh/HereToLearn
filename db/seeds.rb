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
# strategy: "When Seattle Public Schools announced that it would reorganize school start times across the"
# strategy: "district for the fall of 2016, the massive undertaking took more than a year to deploy."
# strategy: "Elementary schools started earlier, while most middle and all of the district's 18 high"
# strategy: "schools shifted their opening bell almost an hour later -- from 7:50 a.m. to 8:45 a.m."
# strategy: "Parents had mixed reactions. Extracurricular activity schedules changed. School buses were"
# strategy: "redeployed."
# strategy: "And as hoped, teenagers used the extra time to sleep in."
# strategy: "In a paper published Dec. 12 in the journal Science Advances, researchers at the University"
# strategy: "of Washington and the Salk Institute for Biological Studies announced that teens at two"
# strategy: "Seattle high schools got more sleep on school nights after start times were pushed later -- a"
# strategy: "median increase of 34 minutes of sleep each night. This boosted the total amount of sleep on"
# strategy: "school nights for students from a median of six hours and 50 minutes, under the earlier start"
# strategy: "time, to seven hours and 24 minutes under the later start time."
# strategy: "This study shows a significant improvement in the sleep duration of students -- all by delaying school start times so that they're more in line with the natural wake-up times of adolescents, said senior and corresponding author Horacio de la Iglesia, a UW professor of"
# strategy: "biology."
# strategy: "The study collected light and activity data from subjects using wrist activity monitors --"
# strategy: "rather than relying solely on self-reported sleep patterns from subjects, as is often done in"
# strategy: "sleep studies -- to show that a later school start time benefits adolescents by letting them"
# strategy: "sleep longer each night. The study also revealed that, after the change in school start time,"
# strategy: "students did not stay up significantly later: They simply slept in longer, a behavior that"
# strategy: "scientists say is consistent with the natural biological rhythms of adolescents."
# strategy: "Research to date has shown that the circadian rhythms of adolescents are simply fundamentally different from those of adults and children, said lead author Gideon Dunster,"
# strategy: "a UW doctoral student in biology."
# strategy: "In humans, the churnings of our circadian rhythms help our minds and bodies maintain an"
# strategy: "internal 'clock' that tells us when it is time to eat, sleep, rest and work on a world that"
# strategy: "spins once on its axis approximately every 24 hours. Our genes and external cues from the"
# strategy: "environment, such as sunlight, combine to create and maintain this steady hum of activity."
# strategy: "But the onset of puberty lengthens the circadian cycle in adolescents and also decreases the"
# strategy: "rhythm's sensitivity to light in the morning. These changes cause teens to fall asleep later"
# strategy: "each night and wake up later each morning relative to most children and adults."
# strategy: "To ask a teen to be up and alert at 7:30 a.m. is like asking an adult to be active and alert at 5:30 a.m., said de la Iglesia."
# strategy: "Scientists generally recommend that teenagers get eight to 10 hours of sleep each night. But"
# strategy: "early-morning social obligations -- such as school start times -- force adolescents to either"
# strategy: "shift their entire sleep schedule earlier on school nights or truncate it. Certain light-"
# strategy: "emitting devices -- such as smartphones, computers and even lamps with blue-light LED bulbs -"
# strategy: "- can interfere with circadian rhythms in teens and adults alike, delaying the onset of"
# strategy: "sleep, de la Iglesia said. According to a survey of youth released in 2017 by the U.S."
# strategy: "Centers for Disease Control and Prevention, only one-quarter of high school age adolescents"
# strategy: "reported sleeping the minimum recommended eight hours each night."
# strategy: "All of the studies of adolescent sleep patterns in the United States are showing that the time at which teens generally fall asleep is biologically determined -- but the time at which they wake up is socially determined, said Dunster. This has severe consequences for health"
# strategy: "and well-being, because disrupted circadian rhythms can adversely affect digestion, heart"
# strategy: "rate, body temperature, immune system function, attention span and mental health."
# strategy: "The UW study compared the sleep behaviors of two separate groups of sophomores, all enrolled"
# strategy: "in biology classes at Roosevelt and Franklin high schools. One group of 92 students, drawn"
# strategy: "from both schools, wore wrist activity monitors all day for two-week periods in the spring of"
# strategy: "2016, when school still started at 7:50 a.m. The wrist monitors collected information about"
# strategy: "light and activity levels every 15 seconds, but no physiological data about the students. In"
# strategy: "2017, about seven months after school start times had shifted later, the researchers had a"
# strategy: "second group of 88 students -- again drawn from both schools -- wear the wrist activity"
# strategy: "monitors. Researchers used both the light and motion data in the wrist monitors to determine"
# strategy: "when the students were awake and asleep. Two teachers at Roosevelt and one at Franklin worked"
# strategy: "at 5:30 a.m., said de la Iglesia."
# strategy: "but the time at which"
# strategy: "they wake up is socially determined, said Dunster. This has severe consequences for health"
# strategy: "the biology classes. Students in both groups also self-reported their sleep data."
# strategy: "The information obtained from the wrist monitors revealed the significant increase in sleep"
# strategy: "duration, due largely to the effect of sleeping in more on weekdays."
# strategy: "Thirty-four minutes of extra sleep each night is a huge impact to see from a single intervention, said de la Iglesia."
# strategy: "The study also revealed other changes beyond additional shut-eye. After the change, the wake-"
# strategy: "up times for students on weekdays and weekends moved closer together. And their academic"
# strategy: "performance, at least in the biology course, improved: Final grades were 4.5 percent higher"
# strategy: "for students who took the class after school start times were pushed back compared with"
# strategy: "students who took the class when school started earlier. In addition, the number of tardies"
# strategy: "and first-period absences at Franklin dropped to levels similar to those of Roosevelt"
# strategy: "students, which showed no difference between pre- and post-change."
# strategy: "The researchers hope that their study will help inform ongoing discussions in education"
# strategy: "circles about school start times. The American Academy of Pediatrics recommended in 2014 that"
# strategy: "middle and high schools begin instruction no earlier than 8:30 a.m., though most U.S. high"
# strategy: "schools start the day before then. In 2018, California lawmakers nearly enacted a measure"
# strategy: "that would ban most high schools from starting class before 8:30 a.m. In 2019, Virginia"
# strategy: "Beach, home to one of the largest school districts in Virginia, will consider changes to its"
# strategy: "school start times."
