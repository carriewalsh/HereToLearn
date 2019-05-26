class StudentsFacade
  attr_reader :id
  def initialize(id)
    @id = id
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
    [student.percent_present, student.percent_absent, student.total_absences]
  end
end
