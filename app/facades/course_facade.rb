class CourseFacade
  attr_reader :current_user, :course
  attr_accessor :group_count

  def initialize(current_user, course, group_count)
    @current_user = current_user
    @course = course
    @group_count = group_count
  end

  def students
    current_user.courses.find(course.id).students
  end

  def present_students
    students.find_all do |student|
      student.todays_attendance.includes?("present") || student.todays_attendance == "tardy"
    end
  end

  def random_groups_all
    students.random_groups(@group_count)
  end

  def random_groups_present
    present_students.random_groups(@group_count)
  end

  def predicted_score
    student_ids = students.map { |student| student.id }
    django_service = DjangoService.new(student_ids)
    @_service ||= django_service.predict_course_scores # return hash of {<id>:{predicted_score: <number>, data: <array of percents>}, ...}
  end
end
