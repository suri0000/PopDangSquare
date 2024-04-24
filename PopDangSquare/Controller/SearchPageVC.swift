//
//  SearchPageVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

class SearchPageVC: UIViewController, UISearchBarDelegate {
    // 추후 네비게이션 연결 후 필요한 코드
    //    .navigationBarBackButtonHidden()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchResult.isHidden = true // 초기에는 검색 결과 레이블을 숨김
        searchBar.delegate = self
    }
    
    // 검색 버튼을 눌렀을 때 호출되는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 키보드 숨기기
        if let searchText = searchBar.text, !searchText.isEmpty {
            searchResult.text = "\(searchText)로 검색된 결과입니다."
            searchResult.isHidden = false // 검색 결과 레이블 보이기
        } else {
            searchResult.isHidden = true // 검색 결과 레이블 숨기기
        }
    }
    
}
