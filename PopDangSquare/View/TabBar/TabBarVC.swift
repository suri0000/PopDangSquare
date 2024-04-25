////
////  TabBarVC.swift
////  PopDangSquare
////
////  Created by 한철희 on 4/25/24.
////
//
//import UIKit
//
//class TabBarVC: UITabBarController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // MainPage 뷰 컨트롤러 생성 및 설정
//        let mainPageVC = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "MainPage")
//        mainPageVC.tabBarItem = UITabBarItem(title: "홈", image: nil, selectedImage: nil)
//        
//        // SearchPage 뷰 컨트롤러 생성 및 설정
//        let searchPageVC = UIStoryboard(name: "SearchPage", bundle: nil).instantiateViewController(withIdentifier: "SearchPage")
//        searchPageVC.tabBarItem = UITabBarItem(title: "검색", image: nil, selectedImage: nil)
//        
//        // DetailView 뷰 컨트롤러 생성 및 설정
//        let detailViewVC = UIStoryboard(name: "DetailView", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController")
//        detailViewVC.tabBarItem = UITabBarItem(title: "준비중", image: nil, selectedImage: nil)
//        
//        // MyPage 뷰 컨트롤러 생성 및 설정
//        let myPageVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPage")
//        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: nil, selectedImage: nil)
//        
//        // 생성된 뷰 컨트롤러들을 탭 바 컨트롤러에 추가
//        viewControllers = [mainPageVC, searchPageVC, detailViewVC, myPageVC]
//    }
//    
//}
