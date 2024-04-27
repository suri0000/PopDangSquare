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
    @IBOutlet weak var detailedResultLabel: UILabel! // 검색 결과를 보여줄 라벨
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    
    // Popular 데이터 구조를 저장한 배열
    var movies: [Popular] = []
    
    let dummyData = ["Apple", "Banana", "Snack", "Chocolate", "Ice Cream"] // 더미 데이터 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupUI()
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
        detailedResultLabel.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text, !searchText.isEmpty {
            // 검색 결과 초기화
            searchResult.isHidden = false
            detailedResultLabel.isHidden = true
            
            // 사용자의 입력을 포함하는 모든 항목을 찾음
            let matchingItems = dummyData.filter { $0.localizedCaseInsensitiveContains(searchText) }
            
            if !matchingItems.isEmpty {
                // 검색된 결과가 있을 경우
                searchResult.text = "\"\(searchText)\"(으)로 검색된 결과입니다."
                // 모든 일치하는 항목을 detailedResultLabel에 표시
                detailedResultLabel.text = "Matching items: \(matchingItems.joined(separator: ", "))"
                detailedResultLabel.isHidden = false
                firstTableView.isHidden = false // 검색된 결과가 있으므로 tableView를 보이게 함
            } else {
                // 검색된 결과가 없을 경우
                searchResult.text = "죄송합니다. \(searchText)으로 검색된 결과를 찾을 수가 없습니다."
                detailedResultLabel.isHidden = true
                firstTableView.isHidden = true // 검색된 결과가 없으므로 tableView를 숨김
            }
        } else {
            searchResult.isHidden = true
            detailedResultLabel.isHidden = true
            firstTableView.isHidden = true // 검색어가 비어있으므로 tableView를 숨김
        }
    }
}

extension SearchPageVC: UITableViewDelegate, UITableViewDataSource {
    //TableView Section 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            // 첫 번째 테이블뷰의 로우 개수 반환
            return 1 // 예를 들어 dummyData 배열의 크기를 반환합니다.
        }
        if tableView == secondTableView {
            // 두 번째 테이블뷰의 로우 개수 반환
            return 5 // 두 번째 테이블뷰에 표시할 로우의 개수를 반환합니다.
        }
        return 0 // 둘 중 어느 것도 아니면 0 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTableView,
           // 첫 번째 테이블뷰의 셀 구성
           let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell {
            return cell
        }
        if tableView == secondTableView,
           // 두 번째 테이블뷰의 셀 구성
           let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as? RecommendCell {
            return cell
        }
        return UITableViewCell() // 둘 중 어느 것도 아니면 기본 UITableViewCell 반환
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == firstTableView {
            return 150 // 첫 번째 테이블뷰의 셀 높이
        }
        if tableView == secondTableView {
            return 150 // 두 번째 테이블뷰의 셀 높이
        }
        return 44 // 기본값
    }
    
}
