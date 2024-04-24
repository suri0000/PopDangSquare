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
        // logoCellTableViewCell register
        tableView.register(UINib(nibName: "LogoCellTableViewCell", bundle: nil), forCellReuseIdentifier: "LogoCellTableViewCell")
        
        // NowPlayingTableViewCell register
        tableView.register(UINib(nibName: "NowPlayingTableViewCell", bundle: nil), forCellReuseIdentifier: "NowPlayingTableViewCell")
        
        // MovieChartTableViewCell register
        tableView.register(UINib(nibName: "MovieChartTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieChartTableViewCell")
        
        // ComingSoonCellTableViewCell register
        tableView.register(UINib(nibName: "ComingSoonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ComingSoonCellTableViewCell")
    }
    
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    //TableView Section 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    //TableView Height 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 280
        case 2:
            return 200
        case 3:
            return 350
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
