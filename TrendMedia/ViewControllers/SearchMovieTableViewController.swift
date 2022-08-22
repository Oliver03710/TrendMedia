//
//  SearchMovieTableViewController.swift
//  TrendMedia
//
//  Created by Junhee Yoon on 2022/07/20.
//

import UIKit

class SearchMovieTableViewController: UITableViewController {

    // MARK: - Properties
    
    var movieList = MovieInfo()
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "theatermasks.fill"), style: .plain, target: self, action: #selector(resetButtonClicked))
    }
    
    
    // MARK: - Selectors
    
    @objc func resetButtonClicked() {

        let sb = UIStoryboard(name: "Trend", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Collection View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell", for: indexPath) as! SearchMovieTableViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: RecommandCollectionViewController.identifier) as! RecommandCollectionViewController
        
        // 2. 값 전달 - vc가 가지고 있는 프로퍼티에 데이터 추가
        
        vc.movieData = movieList.movie[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
