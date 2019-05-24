namespace :attendance do
  desc 'Creates attendance records for all students/courses'
  task populate: :environment do
    student_courses = Student.joins(:courses).select('courses.id as c_id, students.id as s_id')
    student_courses.each do |sc|
      Attendance.create(student_id:sc.s_id, course_id:sc.c_id, attendance:0)
    end
  end
end
