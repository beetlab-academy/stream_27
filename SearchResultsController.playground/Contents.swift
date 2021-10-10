import UIKit

var greeting = "Hello, playground"

let vc = UIViewController()

let controller = UISearchController(searchResultsController: vc)
controller.searchResultsUpdater =

class Test: NSObject, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar
    }
}
