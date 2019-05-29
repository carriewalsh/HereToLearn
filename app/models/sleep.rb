class Sleep
  attr_reader :none,
                    :less_than,
                    :usual,
                    :more_than,
                    :way_more
                    
  def initialize(data)
    @none = data[:none]
    @less_than = data[:less_than]
    @usual = data[:usual]
    @more_than = data[:more_than]
    @way_more = data[:way_more]
end
# {:score=>64.1, :meals_missed=>1.0, :sleep_quality=>
# {:none=>0.0, :less_than=>1.0, :usual=>0.0, :more_than=>0.0, :way_more=>0.0}}
end
