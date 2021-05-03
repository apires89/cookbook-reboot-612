require_relative "view"
require_relative "scrapeallrecipes_service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    ###TODO create view.rb
    @view = View.new
  end

  def list
    #get the recipes from the cookbook(repo)
    #display the list for the user(view)
    @view.display(@cookbook.all)
  end

  def mark_as_done
    #1.list all of the recipes
     list
    #2. Select which one to mark
    selection = @view.ask_user_for_index
    #update the recipe on the cookbook
    @cookbook.mark_recipe_as_done(selection)
    #list
    list
  end

  def import
    #1.Ask for a keyword/ingredient
    keyword = @view.ask_user_for_input("keyword")
    #2.Parse the website using the keyword
    #instantantiating the service
    scrape = ScrapeAllrecipesService.new(keyword)
    #call the service
    #3.Return top5 results from website || fromat: array of instances of Recipe
    top5 = scrape.call
    #4.Display them
    @view.display(top5)
    #5.Ask user to select one(using index)
    selection_index = @view.ask_user_for_index
    recipe = top5[selection_index]
    #6.Add it to the cookbook
    @cookbook.add_recipe(recipe)
    #extra
    list
  end


  def create
    #1.Ask user for a name(view)
    name = @view.ask_user_for_input("name")
    #2.Ask user for a description(view)
    description = @view.ask_user_for_input("description")
    rating = @view.ask_user_for_input("rating")
    prep_time = @view.ask_user_for_input("preparation time")
    #3.create a recipe(model)
    recipe = Recipe.new(name: name,description: description,rating: rating, prep_time: prep_time)
    #4.Store it in the cookbook(repo)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    #1. Get recipes(repo)
    recipes = @cookbook.all
    #2. Display the recipes for user to chose(view)
    @view.display(recipes)
    #3. Ask user for index(view)
    choice = @view.ask_user_for_index
    #4. Remove it from repo (repo)
    @cookbook.remove_recipe(choice)
  end
end
