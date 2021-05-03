class View
  def display(recipes)
    recipes.each_with_index do |recipe,index|

      puts "#{recipe.done ? "[ X ]" : "[ ]"} - #{index + 1} - Name: #{recipe.name} - Description:#{recipe.description} Rating:#{recipe.rating} prep_time:#{recipe.prep_time}"
    end
  end

  def ask_user_for_input(input)
    puts "What is the #{input} of your recipe?"
    gets.chomp
  end


  def ask_user_for_index
    puts "What is the index of your recipe?"
    gets.chomp.to_i - 1
  end

  def message
    puts "Happy Monday!"
  end
end
