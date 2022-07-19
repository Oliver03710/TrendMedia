//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    var movies = Datas()
    
    var isSearching = false
    var searchedData = [String]()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    
    // MARK: - Helper Functions
    
    
    
    
    
    // MARK: - Table View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedData.count
        } else {
            return movies.titles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell

            cell.movieImage.image = UIImage(named: movies.images[indexPath.row])
            cell.movieTitleLabel.text = movies.titles[indexPath.row]
            cell.movieTitleLabel.font = .systemFont(ofSize: 15)
            
            cell.releaseDateLabel.text = movies.dates[indexPath.row]
            cell.releaseDateLabel.font = .systemFont(ofSize: 13)
            
            cell.storyLabel.text = movies.stories[indexPath.row]
            cell.storyLabel.font = .systemFont(ofSize: 13)
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func xButtonTapped(_ sender: UIButton) {
        baseView.isHidden = true
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        baseView.isHidden = false
        view.endEditing(true)
    }
    
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedData = movies.titles.filter({$0.lowercased().components(separatedBy: [" ", ".", ",", "!", "?", "*", "@", "~", "`"]).joined() == searchText.lowercased().components(separatedBy: [" ", ".", ",", "!", "?", "*", "@", "~", "`"]).joined()})
        isSearching = true
        tableView.reloadData()
        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
