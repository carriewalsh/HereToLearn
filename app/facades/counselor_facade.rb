class CounselorFacade
  def initialize(counselor)
    @counselor = counselor
  end

  def students_9
    Student.where(grade_level: 9)
  end

  def students_10
    Student.where(grade_level: 10)
  end

  def students_11
    Student.where(grade_level: 11)
  end

  def students_12
    Student.where(grade_level: 12)
  end

  def flagged_strats
    Strategy.where(flagged: true).where(active: true)
  end
end
