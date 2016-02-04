# 2d-Tableview

![Demo video](https://youtu.be/gwgEpGpX0vg)

A grid of UICollectionView cells, each in horizontal scrolling collection view contained within the larger table view.

I created two classes:
* CollectionViewTableViewCell — a tableview cell that contains a collection view
* TwoDTableView — a subclass of UITableView that is its own data source and delegate 

These can be found in /TwoDTableView.

In order to use this class, you must implement (and set in the table view's property) an object conforming to the twoDTableViewDataSource protocol.  This protocol is deliberately similar to the UITableViewDataSource protocol, but contains methods for returning the collectionView cell at a given row & column, and setting column counts, row counts, and section titles.  Optionally, the twoDTableViewDelegate protocol provides methods to be notified of updates to the table. 

The sample project in /example-project  shows how to use the classes to create a table that is dynamically loaded with the most popular albums in each country on iTunes.  Tapping on an album searches for the album and artist on YouTube.  To run the example, you will need to install the CocoaPod dependencies, using `pod install`. Then, open example-project/smule/smule.xcworkspace/.
