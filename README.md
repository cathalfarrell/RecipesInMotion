# Recipes In Motion
A little simple UIKit Recipe example app that demonstrates unit testing and clean swift architecture

## Installation
Download the code and open the .xcodeproj file in Xcode
Check that the dependency Alamofire is installed via Swift Package Manager, or update it if not.
Install Swiftlint if you want to check for Swiftlint warnings.

### How to use
* The first tab "My Ingredients" - simply displays all of my ingredients
* The last tab "All Recipes" - simply displays all of my recipes
* The most important tab is in the middle "Available Recipes" tab which shows the ingredients and
only displays those recipes that can be made using my ingredients.

### Architecture
Though probably over-kill for a small test app, I have demonstrated Clean Swift architecture.

### Unit Tests
I have included a few unit tests for demonstration purposes, though there are probably many more
that I could have included, so it is not exhaustive.

### Services
You shall find the network call to get the ingredients and the local JSON parsing call to get the Recipes
in the services folder.

### Final Notes
* Though, I was told to spend only 3 hours on this, I spent considerably more. 
* The first hour was spent on getting the services and parsing correct
* The second hour on setting up the units tests
* A third hour laying out the components and then a couple of more hours, testing tweaking and improving.

* In a real build screnario, of course I would include Reachability to test for network connectivity and add error handling etc
but I have put enough time into it for now that I hope it is acceptable.

### Screenshots

![Image description](https://cathalfarrell.com/repo-images/available_recipes.png)

![Image description](https://cathalfarrell.com/repo-images/ingredients.png)

![Image description](https://cathalfarrell.com/repo-images/allrecipes.png)
