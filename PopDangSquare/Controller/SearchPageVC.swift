//
//  SearchPageVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

class SearchPageVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResult: UILabel!
    @IBOutlet weak var detailedResultLabel: UILabel! // 검색 결과를 보여줄 라벨
    @IBOutlet weak var tableView: UITableView!
    
    let dummyData = ["Apple", "Banana", "Snack", "Chocolate", "Ice Cream"] // 더미 데이터 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 관련
        tableView.delegate = self
        tableView.dataSource = self
        
        // SearchResultTableViewCell register
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        
        // UI디자인 관련 추후 함수로 정리 예정
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchResult.isHidden = true
        detailedResultLabel.isHidden = true // 초기에는 결과 라벨을 숨김
        tableView.isHidden = true
        searchBar.delegate = self
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
                tableView.isHidden = false // 검색된 결과가 있으므로 tableView를 보이게 함
            } else {
                // 검색된 결과가 없을 경우
                searchResult.text = "죄송합니다. \(searchText)으로 검색된 결과를 찾을 수가 없습니다."
                detailedResultLabel.isHidden = true
                tableView.isHidden = true // 검색된 결과가 없으므로 tableView를 숨김
            }
        } else {
            searchResult.isHidden = true
            detailedResultLabel.isHidden = true
            tableView.isHidden = true // 검색어가 비어있으므로 tableView를 숨김
        }
    }

    
}


extension SearchPageVC: UITableViewDelegate, UITableViewDataSource {
    //TableView Section 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else {
            // 셀 타입 캐스팅에 실패한 경우 기본 UITableViewCell 반환
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150// 적절한 셀의 높이로 설정하세요.
    }
}
