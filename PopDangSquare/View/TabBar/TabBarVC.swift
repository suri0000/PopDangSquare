//
//  TabBarVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class TabBarVC: UITabBarController {
    
    // MARK: - Variable Part
    
    var cameraButton: UIButton = {
        let button = UIButton()
        // 카메라 버튼 이미지 설정
        button.setBackgroundImage(UIImage(named:"movieclapper"), for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
}

// MARK: - UI Setup

extension TabBarVC {
    
    func setTabBar() {
        // 탭바 아이템 설정
        let homeVC = UIViewController()
        let groupVC = UIViewController()
        
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: -5, right: 0)
        homeVC.tabBarItem.image = UIImage(named: "movieclapper")
        homeVC.tabBarItem.selectedImage = UIImage(named: "movieclapper")
        
        groupVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: -20)
        groupVC.tabBarItem.image = UIImage(named: "movieclapper")
        groupVC.tabBarItem.selectedImage = UIImage(named: "movieclapper")
        
        setViewControllers([homeVC, groupVC], animated: true)
        
        // 카메라 버튼의 크기와 위치 설정
        let width: CGFloat = 70/375 * self.view.frame.width
        let height: CGFloat = 70/375 * self.view.frame.width
        let posX: CGFloat = self.view.frame.width/2 - width/2
        let posY: CGFloat = -32
        
        cameraButton.frame = CGRect(x: posX, y: posY, width: width, height: height)
        
        // 탭바에 카메라 버튼 추가
        tabBar.addSubview(cameraButton)
    }
}

