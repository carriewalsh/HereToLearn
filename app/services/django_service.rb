class DjangoService
  include Clients::Django

  def initialize(student_ids)
    @student_ids = student_ids
  end

  def predict_course_scores
    results = get_json('/machinelearning/results/course', student_ids)
    
  end
end
