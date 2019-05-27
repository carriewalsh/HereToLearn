class StudentFacade
  attr_reader :id, :course
  def initialize(id, course_id)
    @id = id
    @course = Course.find(course_id)
  end

  def student
    Student.find(@id)
  end

  def schedule
    list = student.courses.map do |course|
      "Period #{course.period} - #{course.name}"
    end
    list
  end

  def statistics
    ["Present: #{student.percent_present(@course)}%",
      "Absent: #{student.percent_absent(@course)}%",
      "Total Absences: #{student.total_absences(@course)} days"]
  end

  def strategies
    student.strategies
  end

  def teacher_name(id)
    Teacher.find(id).name
  end
end
