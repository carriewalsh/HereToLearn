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
end
