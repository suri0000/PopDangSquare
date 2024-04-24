//
//  SearchPageVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

class SearchPageVC: UIViewController {
    // 추후 네비게이션 연결 후 필요한 코드
//    .navigationBarBackButtonHidden()

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
    }

}
