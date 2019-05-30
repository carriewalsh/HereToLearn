#currently not in use, potential for the future
class CounselorFacade
  def initialize(counselor)
    @counselor = counselor
  end

  def flagged_strats
    Strategy.where(flagged: true).where(active: true)
  end
end
