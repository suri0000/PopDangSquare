//
//  MyPageInformationVC.swift
//  PopDangSquare
//
//  Created by Developer_P on 4/25/24.
//

import Foundation
import UIKit

class MyPageInformationVC: UIViewController {
    // 마이페이지 배경 연결부
    @IBOutlet weak var myPageInfoBackgroundImage: UIImageView!
    @IBOutlet weak var myPageInfoBackgroundButton: UIButton!
    
    // 마이페이지 프로필 연결부
    @IBOutlet weak var myPageInfoPorfileImage: UIImageView!
    @IBOutlet weak var myPageInfoProfileButton: UIButton!
    
    // 마이페이지 레이블 연결부
    @IBOutlet weak var myPageInfoNameLable: UILabel!
    
    @IBOutlet weak var myPageInfoNameModify: UIButton!
    @IBOutlet weak var myPageInfoEmailLable: UILabel!
    @IBOutlet weak var myPageInfoEmailModify: UIButton!
    @IBOutlet weak var myPageInfoPasswordModify: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

