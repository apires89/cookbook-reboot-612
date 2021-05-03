require "pry-byebug"
require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    #load all exiting recipes
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end

  private

  def load_csv
    #iterate rows of CSV
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      #instatiate the Recipe
      #byebug
      row[:done] = row[:done] == "true"
      row[:rating] = row[:rating].to_f
      recipe = Recipe.new(row)
      # "true" | "false" ---> true | false
      # "true" == "true" --> true
      # "false" == "true" ---> false
      #store it
      @recipes << recipe
    end
  end


  def save_csv
    #open the csv file
    CSV.open(@csv_file, "wb") do |csv|
      csv << ["name", "description", "rating", "done", "prep_time"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating.to_s, recipe.done.to_s,recipe.prep_time]
      end
    end
    #iterate @recipes
    # for each of the recipe store it into the csv file

  end

  #add a recipe
  #list all recipes
  #delete a recipe

  ### methods for csv
end
