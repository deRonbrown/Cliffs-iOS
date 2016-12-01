# Cliffs

[![CI Status](http://img.shields.io/travis/DeRon Brown/Cliffs.svg?style=flat)](https://travis-ci.org/DeRon Brown/Cliffs)
[![Version](https://img.shields.io/cocoapods/v/Cliffs.svg?style=flat)](http://cocoapods.org/pods/Cliffs)
[![License](https://img.shields.io/cocoapods/l/Cliffs.svg?style=flat)](http://cocoapods.org/pods/Cliffs)
[![Platform](https://img.shields.io/cocoapods/p/Cliffs.svg?style=flat)](http://cocoapods.org/pods/Cliffs)

## Overview

Cliffs is a library that makes managing and tagging summary-style analytics events
easy. What is a summary event? A summary event is an analytics event that captures
information on how a user interacts with a particular section of your app or an entire
app usage session (e.g. between foreground and background). For example, suppose you
have a social app that contains a feed of posts. Instead of (or in addition to) tagging
a separate event for each post that is liked or shared, a summary event could tag a
single event with attributes "Number of Posts Liked", "Number of Posts Shared", and/or
"Number of Posts Viewed" when the user leaves that particular view or backgrounds the
app. This allows you to more easily answer questions like "On average how many posts
are liked by users within a given session" without having to look through thousands of
individual "like" events.

## Philosophy

Generally, iOS apps separate user objectives into different `UIViewController` classes.
With Cliffs each `UIViewController` can report it's own summary event by extending
the `CFUIViewController` class. For example, suppose you have a sports app that contains
a `GamesViewController`, a `TeamViewController`, and a `FavoritesViewController`. As
the user interacts with and leaves each `UIViewController`, Cliffs can automatically
report "Game Viewed", "Team Viewed", and "Favorites Viewed" events containing specific
information for what the user did in each view.

`UIViewController` summaries can be "simple reporting". This means the summary event
will be automatically tagged when the user leaves the view (i.e. `viewDidDisappear`)
or when the users backgrounds the app. Summaries that start in a particular
`UIViewController` but end in a different `UIViewController` or another future moment,
such as an onboarding flow, will need to be manually reported.

`UIViewController` summaries also support screen tagging, which are different than
event tags in some analytics providers. Via the automated screen tagging in Cliffs,
a "Previous Screen" attribute will be included in the summary event so
you can easily understand users' previous state before starting a particular objective.

Cliffs also supports summaries not tied to any particular `UIViewController`, such
as a session summary. These can be created and reported as necessary.

## Summary Event Class

Summary events are created by extending the `CFTrackingSummary` class. This class
supports several different property types.
* Identifier: Unique identifier only included for storing the summary in an
`NSDictionary` - not included in the final event attributes.
* Name: The name of the event that will be tagged.
* Flags: `YES` and `NO` values - default to `NO`.
* Counters: `NSInteger` values that can be incremented and decremented.
* Timers: `CFTimer` values that keep time in seconds. Each summary automatically
contains a "Time Spent (Seconds)" timer.
* Attributes: Arbitrary key/values.

Each `CFTrackingSummary` subclass must override the `shouldReportOnBackground`
method. If this method returns `NO`, you must make sure to report the summary
at an appropriate time in the future.

## UIViewController class

Each `CFUIViewController` subclass must override the following methods:

#### `- (BOOL)cf_isSimpleSummary;`

If this method returns `YES`, the summary event will be automatically tagged when
the user leaves the view (i.e. `viewDidDisappear`) or when the user backgrounds the
app. If the method returns `NO`, you must make sure to report the summary event for
this `UIViewController` at an appropriate time in the future.

#### `- (NSString *)cf_screenName;`

Return the screen name to be associated with this `UIViewController`.

#### `- (CFTrackingSummary *)cf_createSummary;`

Create an instance of the `CFTrackingSummary` subclass associated with this
`UIViewController`.

## Integration

1. For each summary event that you want to report, create a `CFTrackingSummary`
subclass. Be sure to initialize all flags, counters, timers, and attributes to
a default state at initialization.
2. Subclass `CFUIViewController` in each of your `UIViewControllers` and override
the methods described above. For non-simple summaries, be sure to report them when
necessary.
3. Create and report any other non-`UIViewController` summaries as needed.
4. In your `UIApplicationDelegate` `application:didFinishLaunchingWithOptions:` method,
initialize Cliffs with a `CFAnalytics` delegate. The `CFAnalytics` protocol connects
Cliffs to your analytics providers.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Cliffs is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Cliffs"
```

## Author

DeRon Brown, dmbrown2010@gmail.com

## License

Cliffs is available under the MIT license. See the LICENSE file for more info.
