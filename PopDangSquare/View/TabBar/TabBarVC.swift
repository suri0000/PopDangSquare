//
//  TabBarVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/25/24.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭바 인스턴스 직접 접근
        let tabBar = self.tabBar
        let appearance = UITabBarAppearance()
        
        // 하얀색 배경으로 설정
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
}

