//
//  MainPageVC.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class MainPageVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 테이블뷰 관련
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        // logoCellTableViewCell register
        tableView.register(UINib(nibName: "LogoCellTableViewCell", bundle: nil), forCellReuseIdentifier: "LogoCellTableViewCell")
        
        // NowPlayingTableViewCell register
        tableView.register(UINib(nibName: "NowPlayingTableViewCell", bundle: nil), forCellReuseIdentifier: "NowPlayingTableViewCell")
        
        // MovieChartTableViewCell register
        tableView.register(UINib(nibName: "MovieChartTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieChartTableViewCell")
        
        // ComingSoonCellTableViewCell register
        tableView.register(UINib(nibName: "ComingSoonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ComingSoonCellTableViewCell")
        if let tableView = tableView {
            tableView.delegate = self
            tableView.dataSource = self
        } else {
            print("tableView가 nil입니다. IBOutlet 연결을 확인하세요.")
        }
        tableView.backgroundColor = UIColor.clear
    }
    
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    //TableView Section 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    // 섹션 푸터 뷰를 투명한 UIView로 설정하여 셀 사이에 간격을 추가
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    // 섹션 푸터 높이를 설정하여 셀 사이의 간격 조절
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20 // 원하는 간격
    }
    //TableView Height 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 260
        case 2:
            return 200
        case 3:
            return 400
        default:
            return 80
        }
    }
    //TableViewCell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCellTableViewCell", for: indexPath) as! LogoCellTableViewCell
            // 추가적인 셀 설정이 필요할 경우 여기에 코드 추가
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingTableViewCell", for: indexPath) as! NowPlayingTableViewCell
            cell.configure()
            // 클로저 구현
            cell.onMovieBooked = { [weak self] movie in
                guard let strongSelf = self else { return }
                let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
                if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                    // show 메소드를 사용하여 화면 전환
                    strongSelf.show(detailViewController, sender: nil)
                }
            }

            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieChartTableViewCell", for: indexPath) as! MovieChartTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComingSoonCellTableViewCell", for: indexPath) as! ComingSoonCellTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
