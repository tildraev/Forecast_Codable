# Forecast Codable
In this project, you will use your knowledge of Swift and Networking to build an app that displays the current weather and a 16-day forecast for a specific city!

Students who complete this project independently or as a pairing will showcase their understanding of the following principles:

* Basic Storyboard constraints
* UITableviews
* Creating Custom `class` objects
* Constants, Variables, and Basic Data Types
* Collections
* Functions
* Control Flow
* IBActions && IBOutlets
* API Calls
* API Documentation
* Codable Protocol


---

##  Before you begin
Please `Fork` then `clone` the repo. You can access the repo here:
[GitHub - Stateful-Academy/Forecast_Codable: A Codable Version of your favorite Golf Weather app!](https://github.com/Stateful-Academy/Forecast_Codable)

Create a local branch named `starter` and track the remote branch `starter`. 

To do this:
 * Open `Terminal`
 * Navigate to the correct `directory`
 * Type `git checkout --track origin/starter` 
	 * Hype


---

## Design
If you build and run the app now that you are on the `starter` branch you will discover that we’ve created the UI for this project for you. We made this decision to allow you to focus on the networking code required. Take a moment and explore the project and how the Interface is set up. Some items to be on the lookout for are:
*  Are all the files `subclassed` properly?
* Are all the `IBOutlets` connected properly?
* How is that `tableView` on a `ViewController`?

Warning: There are some setup steps that we’ve intentionally left undone which the instructions will not inform you how to fix. Though, you cannot fix them at this time. We have also included some design bugs that will cause your app to crash if you do not hunt them and solve them.

---

## API Docs
When you are building an app that will display data from an API; that API will determine the properties of your model. Before you ever create the file for your `Model` You need to familiarize yourself with the documentation provided. 

The API we will be using for today's project is provided by WeatherBit.io. You can access the API documentation via this link:
[Weatherbit | Weather API Documentation](https://www.weatherbit.io/api)

You already have completed your account setup and should know your `API Key`.

Please review the documentation for the specific `endpoint` we will be hitting for today's project. 

[Weatherbit | 16 Day Forecast API Documentation](https://www.weatherbit.io/api/weather-forecast-16-day)

This page has some very good and very important information for you as a developer. It will explain what the `Base URL` will be along with what `parameters` and `Query Items` you will need for the URL.  

This documentation even has an example URL you can compare your `finalURL` to.

Along with an example of the response, you should get back. We are real fans of the last section, `Field Decriptions`, as it provides a key to what the shorthand means.

As an aside.. shouldn’t it be `Field Decryptions`? 🤔

## Review the URL in Postman
With the Forecast project you created last week you should already have a `collection` on Postman which holds the `request` we will be using for this project. Review the data returned to refresh your memory on how the data is `nested`.

If you have lost the request in postman you can follow the instructions below. 

<details>
<summary>Request Instructions</summary>
Within the application Postman, make a new request.
<br>
  
* Add only the `BaseURL`  in the field that is to the right of `GET`.

We want to build our URL piece by piece in `Postman`. The steps to creating a working request in `Postman` will be very similar to the steps you will soon take within Xcode. 

1. Under the `Query Params` add a new key with the key `key`.
	1. I know that confusing to read.. but for this API the keyValue for your APIKey is the word `key`….
2. Under the `Query Params` add a new value to the `key` you just created. The `value` you will add is the `value` for your APIKey.
	1. This should be that crazy long set of characters you got with your account.
	2. I know this is also a challenge to read.. but these are the proper terms to be using.
Congratulations! You just added your first `Query Parameter` to Postman! Press the send button and see what results you get!

Read the documentation to see what other `Query Parameters`  are not optional for the URL. 

As I’m sure you just discovered, the best `Query Parameter`  to use is longitude and latitude. That is not common knowledge. Let’s use the `City Name` parameter instead.

1. Under the `Query Params` add a new key with the key `city`.
2. Under the `Query Params` add a  new value to the `key` you just created. The `value` you will add is whatever city you want to see the weather for.
3. A few quick options you can use are:
	1. Las Vegas
	2. Salt Lake
	3. Boulder

Reading through the results you’ll discover that you are now receiving `16` days worth of forecast data, which is the default amount to return.
( can you change that limit? )
You’ll also discover that the weather units are all displayed in `Celsius`. I don’t know about you, but some grumpy bois didn’t throw a bunch of tea into the sea for me to be writing an app that uses `Celsius`. This is an optional parameter - but if you wish you can change it to `Imperial`.
For the fun of it
* Under the `Query Params` add a new key with the key `units`.
* Under the `Query Params` add a  new value to the `key` you just created. The `value` you will add is `I`
Send the request again you’ll now have a `MERICA`fied result of data. Use this `Final URL` as an example for when you write your `URL` in Xcode.
<br>	
</details>

### Reading the data on Postman
Take a few moments and explore the `nesting`  and structure of the JSON data you will receive from the request you just completed. On the line numbers, these arrows will allow you to collapse the structures. I recommend pressing the arrow on line 2.

Some important notes are:
 1. We have a top-level dictionary that is a dictionary of type String and Any Object
	1. [String:Any]
1. There are a few keys available within the `Top-Level Dictionary`
	1. On the key `”data"` we have a value of an `array` of `String:Any` dictionaries.
	2. One the key `city_name` we have a value of the city name for the results.
	
Now re-open the collapsed section from line 2. This will allow us to see the values with the `String and Any` dictions in the `data` array. Some Important notes are:
1. This level holds the majority of the data we wish to display
2. To display `icon`s we need to access a dictionary of type `String` and `Any` with the key `”weather”`. 
	1. Hint: Remember this when building your `Model`

Awesome! You should now be somewhat comfortable with the data that will be returned from the `endpoint` we aim to use.

Take a break and then we will get to writing some code!

---

## Model
* Create a new `.Swift` file with the name `Day`.
* Create Three new `struct`s
	1. TopLevelDictionary
	2. Day
	3. Weather
* Have all three adopt the `Decodable` protocol

These structs will represent some of the `Dictionary`  objects returned by the API.

### Codable and Structs

Remember - all the data we want is locked in little `Collection` boxes. All we need to do is open them one step at a time. Let's start by opening the top-most data type. 

Within the `struct` `TopLevelDictionary` we need to access the value of two `keys`.
1. City Name
2. Array of Dictionaries under the key `data`

Now, the name `data` doesn’t make much sense, is not very readable, and does not align with the goals of naming as laid out by    in their Human Interface Guide. We will need to change that…

* You can learn more about naming conventions by checking out this link:
	* [Swift.org - API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/#naming)

Fortunately, Apple created a `protocol` for us that will allow us to use our own names while also allowing `Codable` to decode our data properly. This protocol is called `CodingKey`

Within the `struct` `TopLevelDictionary` :
1. Declare a `private` `enum` named `CodingKeys` that adopts `String` and `CodingKey`
	1. The name `CodingKeys` is the name **YOU** are giving the `enum`
	2. The name `CodingKey` is the name of the protocol from Apple.
		1. Be sure you didn’t mistakenly type `CodingKeys`
	3. Within the body of the `CodingKeys` enum add two `case`s
		1. `days` and assign the value of  `”data”`
		2. `cityName` and assign the value of  `”city_name”`
2. Now we can use our own naming conventions. Within the `struct` `TopLevelDictionary` 
	1. Declare a constant named `days` and set the type to an array of `Day`
		1. `Day` is one of the structs you declared earlier…
	2. Declare a constant named `cityName` and set the type to a `String`

Nice work! You just completed the setup for `Codable` to decode the topLevelDictionary!

<details>
  <summary>Check Your Work</summary>
  
  
``` swift
struct TopLevelDictionary: Decodable {
  private enum CodingKeys: String, CodingKey {
      case days = "data"
      case cityName = "city_name"
    }
  let days: [Day]
  let cityName: String
  }
 ```
</details>

Now, all we have left to do is complete the setup of the other two `struct`s…

Within the `struct` `Day` :
1. Declare a `private` `enum` named `CodingKeys` that adopts `String` and `CodingKey`
	1. The name `CodingKeys` is the name **YOU** are giving the `enum`
	2. The name `CodingKey` is the name of the protocol from Apple.
		1. Be sure you didn’t mistakenly type `CodingKeys`
	3. Within the body of the `CodingKeys` enum add five `case`s
		1. `temp` 
			1. Because the name we are using matches the `Key` we do not need to set a value
		2. `highTemp` and assign the value of  `”high_temp”`
		3. `lowTemp` and assign the value of  `”low_temp"`
		4. `validDate` and assign the value of `”valid_date”`
		5. `weather` 
			1. Because the name we are using matches the `Key` we do not need to set a value
2. Now we can use our own naming conventions. Within the `struct` `Day` 
	1. Declare a constant named `temp` and set the type to a  `Double`
	2. Declare a constant named `highTemp`  and set the type to a  `Double`
	3. Declare a constant named `lowTemp`  and set the type to a  `Double`
	4. Declare a constant named `validDate` and set the type to a `String`
	5. Declare a constant named `weather` and set the type to `Weather`
		1.  `Weather` is one of the structs you declared earlier…

Within the `struct` `Weather` :
1. Declare a `private` `enum` named `CodingKeys` that adopts `String` and `CodingKey`
	1. The name `CodingKeys` is the name **YOU** are giving the `enum`
	2. The name `CodingKey` is the name of the protocol from Apple.
		1. Be sure you didn’t mistakenly type `CodingKeys`
	3. Within the body of the `CodingKeys` enum add two `case`s
		1. `description` 
			1. Because the name we are using matches the `Key` we do not need to set a value
		2. `iconString` and assign the value of  `”icon”`
2. Now we can use our own naming conventions. Within the `struct` `Weather` 
	1. Declare a constant named `description` and set the type to a  `String`
	2. Declare a constant named `iconString`  and set the type to a  `String`

Great work! You just completed your first `Codable` Model! Well done! Commit these changes.

---

## Network Controller
Create the `NetworkController` file and `class`.

Take a moment and reflect on the purpose of a `NetworkController` and what we need for this project. 

### Helper Functions
All we need to accomplish the goals of this app is  `fetch` the data from the API. At this time no additional functions are required. 

### Complete the Fetch Function
Declare a `static` function named `fetchDays`

Within the `fetchDays` function we have a few goals: 

1. First, we need to decide what we want the `fetch` function to complete. Because this function will be responsible for hitting an `API Endpoint`, we know it will need a completion handler. 
2. Then, we need to piece together our URL. 
3. Once we have a `finalURL` we will pass that into the `dataTask(with: _, completion: )` function. This will `complete` with a `response` and either an `error` or `data`. 
4. If we are successful in retrieving data from the `dataTask` we will then need to decode that `data` into our objects. 

With our goals laid out let’s start building this piece by piece.

#### Completion - Fetch
When deciding what your closures should complete you should consider *how* you want to use the data. Do you want to have a single object available with the task is done? Maybe you want an `array` of objects instead… Would you rather not have any objects, but just a `Bool` that tells you where it worked or not? Each has its merits. 

For this project, we have decided it would be best to complete with an `Optional` `TopLevelDictionary` object. This will complete with a valid `TopLevelDictionary` if everything worked.

We want to complete with a `TopLevelDictionary` because all the data we want to display will be nested within.

* Modify your `fetchDays` function to have one parameter named `completion` that is marked as `@escaping` and takes in a `Optional TopLevelDictionary` value and  `return`  Void.

<details>
<summary>How do I write this?</summary>
<br>
No hint here, I believe you can do this on your own.
<br>	
</details>

Nice work! Let’s move on to the URL

---

#### URL Finalized

Here is what the `finalURL` will look like once it's fully built. 
`https://api.weatherbit.io/v2.0/forecast/daily?key=YOURKEY&city=YOURCITY` 
Reference back to this while building the smaller pieces.

* Create a `private` and `static` property `above` the declaration of the `fetchdays` function. This property will not change and should be named `baseURLString`. 
* Assign the value of the most consistent aspect of the URL as described on the API documentation.

Now, let’s navigate to inside the body of the `fetchDays(completion: TopLevelDictionary?)`. To create your `finalURL` we will need to perform the following tasks:

* guard that you can initialize a new URL  named `baseURL`from the `baseURLSTring`
	* else { return }
* Create a new variable named `urlComponents`  and assign the value of a `URLComponents` initialized with a url that also is resolving against the BaseURL.

<details>
<summary>How do I write this?</summary>

  
``` swift
var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
```
</details>


* access the `path` property of the `urlComponents` you just declared and assign a `String Literal` of the missing `path Components`
	* Postman and the Documentation will tell you what you need
* Create a new variable named `apiQuery`  and assign the value of a `URLQueryItem` initialized with a name - `”key"`” and a value - `“Whatever your api Keys value is”`
*  Create a new variable named `cityQuery`  and assign the value of a `URLQueryItem` initialized with a name - `”city"`” and a value - `“Whatever city you want the weather of”`
*  Create a new variable named `unitsQuery`  and assign the value of a `URLQueryItem` initialized with a name - `”units"`” and a value - `“I”`
* Call the `urlComponents` you initialized earlier
	* Using `dot Notation` access the `queryItems` property and assign the value of a default array that holds the `URLQueryItem`s you just initialized.
* Guard that you can create a constant named `finalURL` from the optional  `url` property on the `urlComponents`
	* else {return}
* Print out the `finalURL` for testing

Build and run. You may need to bug hunt the bugs on Interface Builder we added….

 Commit, and take a 15 min break! We are now 1/3 of the way complete with our `fetchDays(completion: (TopLevelDictionary?)-> Void)`

<details>
<summary>How do I write this?</summary>


``` swift
var urlComponents = URLComponents(url: dailyURL, resolvingAgainstBaseURL: true)
urlComponents?.path = “/v2.0/forecast/daily”
let apiQuery = URLQueryItem(name: “key”, value: “YOUR KEYS VALUE”)
let cityQuery = URLQueryItem(name: “city”, value:”THE CITY YOU WANT”)
let unitsQuery = URLQueryItem(name: “units”, value: “I”)
urlComponents?.queryItems = [apiQuery,cityQuery,unitsQuery]
print(finalURL)
```	
</details>

---

#### DataTasking

Under the creation of the `finalURL` we will perform a `dataTask` that will  `complete` with a `response` and either an `error` or `data`. If we are successful in retrieving data from the `dataTask` we will then need to decode that `data` into our objects. Once we have our objects we can add them to the `source` of truth. To accomplish this we need to:

* call the `dataTask(with: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void)` from the `shared` singleton on the `URLSession` class
	* pass in the `finalURL`
	* press `enter` on the autocompleteable aspect of the closure.
		* ( I made that name up, ¯\_(ツ)_/¯ )
	* Immediately head to the closing brace of this method and call `.resume()`
		* The program will not run without this line
	* name each item
		* dayData
		* _
		* error
	* conditionally unwrap an `error`
		* If `true` 
			* print `”"There was an error fetching the data. The url is \(finalURL), the error is \(error.localizedDescription)”`
			* completion(nil)
	* We are going to ignore the `response`
	* guard you can create `data` from `dayData`
		* else 
		* print `"There was an error recieveing the data!"`
			* completion(nil)
			* return
	
Okay, this next section will be the most challenging aspect of your Paired Programming Project.
* Declare a Do -> Try -> Catch block
* Within the body of the `do`
	* Create a new constant named `topLevelDictionary`
	* Assign the value of `try`
		* Initialize a `JSONDecoder` and access the `.decode` method
		* decode the type `TopLevelDictionary.self` from the `data` you just unwrapped.
	* Call your completion and pass in the `topLevelDictionary` you just created via decoding the `data`


* After the closing brace of the `do`  
	*  `catch`
		*  print `”Error in Do/Try/Catch: \(error.localizedDescription)”`
		* call the completion as nil

Take a well-deserved sigh of relief. We did it! We have now completed the networking code required to hit the `API Endpoint` and parse the data to create our objects! Well done. 

Isn’t using `Codable` cleaner than when we used `JSONSerialization`?

* A - Always
* B - Be
* C - Committing

Build. Run. Commit. Party

---

## Wire Up the views
You have two `View` files you’ll need to complete. One is for the `DayDetailsViewController` and one is for the `DayForcastTableViewCell`. We feel that you should be getting more and more comfortable with the step of wiring up the views so the instructions for this will be light

### DayForcastTableViewCell

Create a `updateView` function with a parameter of type `Day` and set the value of the two `Label`s and single `imgeView` accordingly.
* Valid Data
* High temp - handle the error
* Create an image from the `day.weather.imageString`

---

### DayDetailsTableViewController
* Create a local property named `days` and assign the value of empty array
	* Based on the name, what type should this be?
* Create a local property named `forcastData` and assign the value of an optional `TopLevelDictionary`
* Create a helper function called `updateViews`
* In the `viewDidLoad`
	* call the `fetchDays` function
	* press `enter` on the `autocompleteable` aspect of the closure.
		* ( I made that name up, ¯\_(ツ)_/¯ )
	* replace the `TopLevelDictionary?` with the word `forcastData`
	* guard you can create a constant named `forcastData` from the value of `forcastData`
	* set the local property `forcastData` to the `forcastData` you just unwrapped.
	* set the local property `days` to the `days` from `forcastData`
	* On the main thread
		* call the `updateViews`  helper function
		* reload the data of the `dayForcastTableView`
* In the `updateViews`
	* Retrieve the first `day` in the `days` array
		* Set the properties of the Labels accordingly
			* Handle the type-mismatches
* set the number of rows
* complete the `cellForRow(at:)` function
	* Retrieve the `day` that matches
	* call the `updateView` function on cell and pass in the day

---

Victory? At this time build and run the app. It may NOT work unless you found the bugs we left hidden in the project. Begin your bug hunt after a cool 15 min break.

---

Found the bugs and everything is golden? Heck yeah! Submit your project.
