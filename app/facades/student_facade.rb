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
    ordered = student.courses.order(:period)
    list = ordered.map do |course|
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

  def prediction_results
    binding.pry
    conn = Faraday.new("http://lit-fortress-28598.herokuapp.com/machinelearning/results/?student_id=#{student.student_id}")
    results = conn.get
    data = JSON.parse(results.body, symbolize_names: true)
    # {:score=>64.1, :meals_missed=>1.0, :sleep_quality=>{:none=>0.0, :less_than=>1.0, :usual=>0.0, :more_than=>0.0, :way_more=>0.0}}
    Prediction.new(data)
  end
end
