class Prediction
  attr_reader :test_score,
                    :meals_missed,
                    :sleep_quality
                    
  def initialize(data)
    @test_score = data[:score]
    @meals_missed = data[:meals_missed]
    @sleep_quality = Sleep.new(data[:sleep_quality])
  end
end
# {:score=>64.1, :meals_missed=>1.0, :sleep_quality=>{:none=>0.0, :less_than=>1.0, :usual=>0.0, :more_than=>0.0, :way_more=>0.0}}
