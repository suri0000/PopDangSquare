//
//  AppDelegate.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/22/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 윈도우 생성
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // UITabBarController 인스턴스 생성
        let tabBarController = UITabBarController()
        
        // 첫 번째 탭: MainPage
        let mainPageVC = MainPageVC() // MainPageViewController는 사용자가 정의한 뷰 컨트롤러 클래스 이름으로 가정합니다.
        mainPageVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home_icon"), selectedImage: UIImage(named: "home_icon_selected"))
        
        // 두 번째 탭: SearchPage
        let searchPageVC = SearchPageVC() // SearchPageViewController는 사용자가 정의한 뷰 컨트롤러 클래스 이름으로 가정합니다.
        searchPageVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search_icon"), selectedImage: UIImage(named: "search_icon_selected"))
        
        // 세 번째 탭: DetailView
        let detailViewVC = DetailViewController() // DetailViewController는 사용자가 정의한 뷰 컨트롤러 클래스 이름으로 가정합니다.
        detailViewVC.tabBarItem = UITabBarItem(title: "준비중", image: UIImage(named: "detail_icon"), selectedImage: UIImage(named: "detail_icon_selected"))
        
        // 네 번째 탭: MyPage
        let myPageVC = MyPageLoginController() // MyPageViewController는 사용자가 정의한 뷰 컨트롤러 클래스 이름으로 가정합니다.
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "mypage_icon"), selectedImage: UIImage(named: "mypage_icon_selected"))
        
        // 탭 바 컨트롤러에 뷰 컨트롤러 배열 추가
        tabBarController.viewControllers = [mainPageVC, searchPageVC, detailViewVC, myPageVC]
        
        // 탭 바 컨트롤러를 루트 뷰 컨트롤러로 설정
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

