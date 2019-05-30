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
    student.strategies.where(active: true)
  end

  def teacher_name(id)
    Teacher.find(id).name
  end

  def prediction_results
    conn = Faraday.new("http://lit-fortress-28598.herokuapp.com/machinelearning/results/?student_id=#{student.student_id}")
    if conn.get.body.include?("IndexError")
      "Data Not Available"
    else
      results = conn.get
      data = JSON.parse(results.body, symbolize_names: true)
      Prediction.new(data)
    end
  end

  def built_ins
    StrategyReference.all.pluck(:built_in)
  end

  def chart_percents(course)
    chart_data = {}
    student.attendances.map do |attendance|
      chart_data[attendance.created_at.strftime('%e-%b')] = attendance.percent_this_date(course)
    end
    chart_data
  end
end
