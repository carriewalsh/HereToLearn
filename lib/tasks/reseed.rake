namespace :reseed do
  desc "Clears out attendance and repopulates it"
  task rebuild_attendance: [:populate, :mark_absent, :generate_codes] do
  end

  desc 'Clears/creates attendance records for all students/courses'
  task populate: :environment do
    Attendance.destroy_all
    student_courses = Student.joins(:courses).select('courses.id as c_id, students.id as s_id')
    student_courses.each do |sc|
      Attendance.create(student_id:sc.s_id, course_id:sc.c_id, attendance: nil)
    end
  end


  desc 'Marks students as absent, who have not responsed, in designated course'
  task :mark_absent, [:course_id] => :environment do |t, args|
    course_id = args[:course_id]
    now = DateTime.now
    time_range = (now.beginning_of_day..now)
    unmarked = Attendance.where(course_id: course_id, created_at:time_range, attendance: nil)
    unmarked.each do |attendance|
      attendance.update_attribute(:attendance, 'absent')
    end
  end

  desc 'Generates codes for each course in the database'
  task generate_codes: :environment do
    Course.all.each do |course|
      Code.create(course_id: course.id, code: SecureRandom.hex(2))
    end
  end
end
