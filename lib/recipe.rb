# class Recipe
#   attr_reader :name,:description,:rating,:done
#   def initialize(name,description,rating = 0,done=false)
#     @name = name
#     @description = description
#     @rating = rating
#     @done = done
#   end

#   def mark_as_done!
#     @done = true
#   end
# end

class Recipe
  attr_reader :name,:description,:rating,:done,:prep_time
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time] || "5 mins"
    @done = attributes[:done] || false
  end

  def mark_as_done!
    @done = true
  end
end
