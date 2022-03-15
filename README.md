# Github-Followers

GitHub-Followers is an iOS native application, written in Swift programming language. This project is based on the Sean Allen's Take Home Project Course, however,
it is adjusted to my coding style and practices. Many things have been done differently, especially regarding the used architecture patterns.

The main functionality of this app is to search for GitHub users, show basic information about those users and add them to favorites for a quick and easy search.

The first screen to show up is the search screen, where you can type in the GitHub user who you want to search for, and by pressing the "Get Followers" button
the HTTP request to the GitHub API is being sent.

![SearchScreen](Screenshots/SearchScreen.png =200x433)

Having fetched the data from GitHub API, it is being decoded using JSONDecoder and the decoded data is being shown in the form of followers. This screen is 
implemented using pagination, which means that a maximum of 100 followers are being fetched by a single HTTP request, and scrolling down to the end, a new
HTTP request is being sent to fetch another 100 users.  

In the top right corner there is a UIBarButtonItem which enables you to save the searched user in your favorites tab.  

Pressing any of the collection view cells modally presents another view controller which shows you detailed information about the selected user.

![FollowersScreen](Screenshots/FollowersScreen.png =200x433)

Selecting the "GitHub Profile" button will present SafariViewController and the user's profile. And for the "Get Followers" button, it has the same effect
as it does on the Home Screen, it will search for followers of the currently presented user.

![UserInfoScreen](Screenshots/UserInfoScreenScreen.png =200x433)
![SafariScreen](Screenshots/SafariScreen.png =200x433)

Sliding the table view cell to the left will remove the user from favorites.

![FavoritesScreen](Screenshots/FavoritesScreen.png =200x433)
![RemoveFromFavoritesScreen](Screenshots/RemoveFromFavoritesScreen.png =200x433)


