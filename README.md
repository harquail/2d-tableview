# smule interview question

##Task:
Create a two dimensional table view where each individual row of a standard
table view houses its own independent view full of cells that can scroll left and
right. (See image)
Data should be loaded from an online source such as a google image search.
Be sure to use asynchronous code to handle your callbacks.

##Deliverable:
Show off your new class in an app (simulator is fine) that creates several rows
each housing several images as the cells. Your images can be whatever you
choose, including just repeating the same image over and over again. Zip up this
project directory and email it to us.

##Specifics:
Answers are widely open to interpretation, though they must show correct
memory management and consistent coding style. Your app can be barebones
as necessary to get the task done, however a more complete answer would be a
reusable module, likely in a form similar to a subclass of a UITableView extending
the existing delegate methods of UITableViewDelegate and
UITableViewDataSource to populate new 2D table view cells.

##Some nice-to-haves to consider:
* If the user taps on a cell make the app respond.
* Make the theme of your test app/images musical and smulean!
* Allow user to tap on an individual cell to trigger an event in your delegate
methods.
* Allow the number of horizontal cells as well as cell width to be customized in your
delegate methods.
* BIG BONUS: allow the user to edit position of cells as they can with
UITableView's edit methods.
* Anything cool you'd like to add to impress us.

![feature spec](https://github.com/harquail/smule-2d-tableview/blob/master/featurespec-image.png)

# My Solution

A grid of UICollectionView cells, each in horizontal scrolling collection view contained within the larger table view.

I created two classes:
* CollectionViewTableViewCell — a tableview cell that contains a collection view
* TwoDTableView — a subclass of UITableView that is its own data source and delegate 

These can be found in /TwoDTableView.

In order to use this class, you must implement (and set in the table view's property) an object conforming to the twoDTableViewDataSource protocol.  This protocol is deliberately similar to the UITableViewDataSource protocol, but contains methods for returning the collectionView cell at a given row & column, and setting column counts, row counts, and section titles.  Optionally, the twoDTableViewDelegate protocol provides methods to be notified of updates to the table. 

The sample project in /example-project  shows how to use the classes to create a table that is dynamically loaded with the most popular albums in each country on iTunes.  Tapping on an album searches for the album and artist on YouTube.  To run the example, you will need to install the CocoaPod dependencies, using `pod install`. Then, open example-project/smule/smule.xcworkspace/.
