#currently not in use, potential for the future
class CounselorFacade
  def initialize(counselor)
    @counselor = counselor
  end

  def header
    "Students by Grade for #{@counselor}"
  end

  def students_by_grade
    @counselor.courses.find(course.id).students

    # course = @counselor.teacher_courses.first.id
    # Course.joins(:student_courses, :students).select('students.*').where(id: course)
  end

end
