# NewsApiApp

This is a fairly typical Xcode Project. Note that it includes Pods so please open the NewsApiApp.xcworkspace. I have included Pods in the Repo. This is to save time setting up the App. The Pod included is SDWebImage. This is used to download images from the Internet.

This App does the following:
* Demonstrates the VIPER architecture patten as applied to a basic News Story App.
* Retrieves items from the API using the keyword “art” in the English language. Note that this can be changed in NewsTableViewController by modifying “KEYWORD”. The language is also configurable by changing “LANGUAGE”.
* Unit Tests for the above.
* Basic fade in animation when cells enter the table

Additionally, pressing on each news story will show that story in Safari.

There are some unit tests in NewsApiAppTests. 

Note there is very little network error checking apart from the obvious network error checking. Also there is no post-processing of content to ensure HTML (etc) is not in the feed.
