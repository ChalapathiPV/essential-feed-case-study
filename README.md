# EssentialFeed
Essential Feed App – Image Feed Feature
BDD Specs
Story: Customer requests to see their image feed
Narrative #1
As an online customer I want the app to automatically load my latest image feed So I can always enjoy the newest images of my friends

Scenarios (Acceptance criteria)
Given the customer has connectivity
When the customer requests to see their feed
Then the app should display the latest feed from remote
  And replace the cache with the new feed
Narrative #2
As an offline customer I want the app to show the latest saved version of my image feed So I can always enjoy images of my friends

Scenarios (Acceptance criteria)
Given the customer doesn't have connectivity
And there’s a cached version of the feed
When the customer requests to see the feed
Then the app should display the latest feed saved

Given the customer doesn't have connectivity
And the cache is empty
When the customer requests to see the feed
Then the app should display an error message
Use Cases
Load Feed Use Case
Data:
URL
Primary course (happy path):
Execute "Load Feed Items" command with above data.
System downloads data from the URL.
System validates downloaded data.
System creates feed items from valid data.
System delivers feed items.
Invalid data – error course (sad path):
System delivers error.
No connectivity – error course (sad path):
System delivers error.
Load Feed Fallback (Cache) Use Case
Data:
Max age
Primary course:
Execute "Retrieve Feed Items" command with above data.
System fetches feed data from cache.
System validates cache age.
System creates feed items from cached data.
System delivers feed items.
Expired cache course (sad path):
System delivers no feed items.
Empty cache course (sad path):
System delivers no feed items.
Save Feed Items Use Case
Data:
Feed items
Primary course (happy path):
Execute "Save Feed Items" command with above data.
System encodes feed items.
System timestamps the new cache.
System replaces the cache with new data.
System delivers success message.
Flowchart
Feed Loading Feature

Architecture
Feed Loading Feature

Model Specs
Feed Item
Property	Type
id	UUID
description	String (optional)
location	String (optional)
imageURL	URL
Payload contract
GET *url* (TBD)

200 RESPONSE

{
	"items": [
		{
			"id": "a UUID",
			"description": "a description",
			"location": "a location",
			"image": "https://a-image.url",
		},
		{
			"id": "another UUID",
			"description": "another description",
			"image": "https://another-image.url"
		},
		{
			"id": "even another UUID",
			"location": "even another location",
			"image": "https://even-another-image.url"
		},
		{
			"id": "yet another UUID",
			"image": "https://yet-another-image.url"
		}
		...
	]
}
Footer
