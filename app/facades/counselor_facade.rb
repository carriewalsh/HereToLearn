class CounselorFacade
  def initialize(counselor)
    @counselor = counselor
  end

  def students
    Student.all
  end

  def flagged_strats
    Strategy.where(flagged: true).where(active: true)
  end
end
