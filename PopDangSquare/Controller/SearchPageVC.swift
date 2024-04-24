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
    
    let dummyData = ["Apple", "Banana", "Snack", "Chocolate", "Ice Cream"] // 더미 데이터 배열

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchResult.isHidden = true
        detailedResultLabel.isHidden = true // 초기에는 결과 라벨을 숨김
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text, !searchText.isEmpty {
            // 검색 결과 초기화
            searchResult.isHidden = false
            detailedResultLabel.isHidden = true
            
            searchResult.text = "\(searchText)(으)로 검색된 결과입니다. "
            
            // 사용자의 입력을 포함하는 모든 항목을 찾음
            let matchingItems = dummyData.filter { $0.localizedCaseInsensitiveContains(searchText) }
            
            if !matchingItems.isEmpty {
                // 모든 일치하는 항목을 detailedResultLabel에 표시
                detailedResultLabel.text = "Matching : \(matchingItems.joined(separator: ", "))"
                detailedResultLabel.isHidden = false
            } else {
                detailedResultLabel.text = "No matching items found."
                detailedResultLabel.isHidden = false
            }
        } else {
            searchResult.isHidden = true
            detailedResultLabel.isHidden = true
        }
    }
}


