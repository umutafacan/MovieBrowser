#  MOVIE BROWSER

## FEATURES

### Movie List
- Lists movies ordered from the most recent to least
- All movies are not fetched, with `load more` button fetches another batch of movies
- Layout change button at navigation bar will toggle layout of movie cells between grid and list
- Favorited movies has star badge.

### Movie Detail
- Movie's poster, title, overview, vote avarage and vote count is shown.
- Movie can be marked as favorite

## Code Architecture

- MVVM architecture is preferred to make more modular and organized code, dividing duties between classes enables
easier unit testing. Also more inclined to reusable classes. 

- Coordinator pattern is used to seperate routing logic from view controllers, so coupling between view controllers are decreased.
While view controller does only call completion block of coordinator, coordinator knows which view controller should be presented or
action should be taken. If project has more flows, more coordinators will be placed to organize routing logics. Even reusing coordinators, 
some patterns can be easily created again. 

- Using protocol for data controllers, makes easier to unit testing. Because mock data controller can be created by just conforming protocol.

- `State Change` is used for communication  between view model and view controller. 
More tidier than delegate pattern and makes more dummier view controller.

- Categories are preferred more than base classes, easier to manage and to combine features over objects.

- Prefered Xib files for Views rather than storyboard because using segues makes coupling between view controllers. 
If segues are not used, using storyboard will suffer for loading times at Xcode with over-populated storyboards.
Also using pure code for constraints and views are makes easier to read git logs however makes crowded view controllers for basic layouts.

### Network

- For object mapping `Codable` protocol is preferred, light-weight, easy to maintain.

- For Networking operation, native url session prefered above Alamofire etc. Because there is less complicated requests such as cookies, 
certificate pinning, authantication etc. Hence, no need to add dependency to project by adding framework. Also it enables more customization, if needed.

### Data Store

- `NSKeyedArchiver` and `NSKeyedUnarchiver` are used for storing favorite movies info. 
Storing at `Keychain` would be unnecessary because more sensitive data should be kept, it should not be populated by these kind of informations.
`NSUserDefaults` also not safe place to store, other than user configurations on app and other insensitive small amount of data.
`CoreData` is over-kill for storing these informations. It would make code more complicated for a simple need. 
However if we setup a caching for all movie infos, it would be choice.

