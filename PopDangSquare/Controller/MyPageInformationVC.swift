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
        
        // 배경 이미지를 원형으로 만들기
        myPageInfoPorfileImage.layer.cornerRadius = myPageInfoPorfileImage.frame.size.width / 2
        myPageInfoPorfileImage.clipsToBounds = true
        
        // 배경 버튼을 원형으로 만들기
        myPageInfoProfileButton.layer.cornerRadius = myPageInfoProfileButton.frame.size.width / 2
        myPageInfoProfileButton.clipsToBounds = true
        
        // 그림자 추가
        myPageInfoPorfileImage.layer.shadowColor = UIColor.black.cgColor
        myPageInfoPorfileImage.layer.shadowOpacity = 0.5
        myPageInfoPorfileImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        myPageInfoPorfileImage.layer.shadowRadius = 4
    }
}
