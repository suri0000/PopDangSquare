//
//  MyPageInformationVC.swift
//  PopDangSquare
//
//  Created by Developer_P on 4/25/24.
//

import Foundation
import UIKit

class MyPageInformationVC: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationController 초기화 및 설정
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewControllerID")

        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
}
