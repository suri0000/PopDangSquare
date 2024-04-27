//
//  SearchPageVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

class SearchPageVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResult: UILabel!
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    
    // 영화 데이터 구조를 저장한 배열
    var movies: [Popular] = []
    var searchMovie: [NowPlaying] = []
    var filteredMovies: [NowPlaying] = []
    
    var dummyData = ["Apple", "Banana", "Snack", "Chocolate", "Ice Cream"] // 더미 데이터 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupUI()
        fetchMovies()
        fetchSearchMovies()
    }
    
    private func fetchMovies() {
        PopularManager.shared.fetchMovies { [weak self] (movies, error) in
            DispatchQueue.main.async {
                if let movies = movies {
                    // 영화 목록을 랜덤하게 섞음
                    var shuffledMovies = movies.shuffled()
                    // 섞인 목록에서 처음 5개의 영화만 선택
                    let randomFiveMovies = Array(shuffledMovies.prefix(5))
                    self?.movies = randomFiveMovies
                    // TableView 리로드
                    self?.secondTableView.reloadData()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchSearchMovies() {
        NowPlayingManager.shared.fetchMovies { [weak self] (movies, error) in
            DispatchQueue.main.async {
                if let movies = movies {
                    self?.searchMovie = movies // 모든 영화 데이터를 배열에 할당
                    // 영화 제목만 추출하여 dummyData 배열을 업데이트
//                    self?.dummyData = movies.map { $0.title }
                    self?.firstTableView.reloadData()
                    print(movies.count)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func setupTableView() {
        firstTableView.delegate = self
        firstTableView.dataSource = self
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
        firstTableView.backgroundColor = .clear
        firstTableView.separatorStyle = .none
        secondTableView.backgroundColor = .clear
        secondTableView.separatorStyle = .none
        
        firstTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        secondTableView.register(UINib(nibName: "RecommendCell", bundle: nil), forCellReuseIdentifier: "RecommendCell")
        
        firstTableView.isHidden = true
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
    }
    
    private func setupUI() {
        recommendView.backgroundColor = .clear
        searchResult.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let searchText = searchBar.text, !searchText.isEmpty {
                // 검색 결과 초기화
                filteredMovies = searchMovie.filter { movie in
                    movie.title.localizedCaseInsensitiveContains(searchText) || movie.originalTitle.localizedCaseInsensitiveContains(searchText)
                }
                
                if !filteredMovies.isEmpty {
                    // 검색된 결과가 있을 경우
                    searchResult.text = "\"\(searchText)\"(으)로 검색된 결과입니다."
                    // 모든 일치하는 항목의 title을 detailedResultLabel에 표시
                    searchResult.isHidden = false
                    firstTableView.isHidden = false // 검색된 결과가 있으므로 tableView를 보이게 함
                    firstTableView.reloadData() // 검색 결과에 따라 TableView를 리로드
                } else {
                    // 검색된 결과가 없을 경우
                    searchResult.text = "죄송합니다. \(searchText)으로 검색된 결과를 찾을 수가 없습니다."
                    searchResult.isHidden = false
                    firstTableView.isHidden = true // 검색된 결과가 없으므로 tableView를 숨김
                }
            } else {
                // 검색어가 비어있을 경우
                searchResult.isHidden = true
                firstTableView.isHidden = true
            }
        }

}

extension SearchPageVC: UITableViewDelegate, UITableViewDataSource {
    //TableView Section 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return filteredMovies.count
        }
        if tableView == secondTableView {
            return movies.count
        }
        return 0 // 둘 중 어느 것도 아니면 0 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTableView,
           // 첫 번째 테이블뷰의 셀 구성
           let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell {
            let movie = filteredMovies[indexPath.row]
            cell.configure(with: movie)
            return cell
        }
        if tableView == secondTableView,
           // 두 번째 테이블뷰의 셀 구성
           let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as? RecommendCell {
            let movie = movies[indexPath.row]
            cell.configure(with: movie)
            return cell
        }
        return UITableViewCell() // 둘 중 어느 것도 아니면 기본 UITableViewCell 반환
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == firstTableView {
            return 160 // 첫 번째 테이블뷰의 셀 높이
        }
        if tableView == secondTableView {
            return 160 // 두 번째 테이블뷰의 셀 높이
        }
        return 44 // 기본값
    }
    
}
