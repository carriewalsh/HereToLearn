#currently not in use, potential for the future
class CounselorFacade
  def initialize(counselor)
    @counselor = counselor
  end

  def students(user)
    Student.joins(courses: :teacher_courses)
           .where('teacher_courses.teacher_id =?', user.id)
  end

  def flagged_strats
    Strategy.where(flagged: true).where(active: true)
  end
end
