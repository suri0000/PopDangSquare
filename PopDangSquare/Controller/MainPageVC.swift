import UIKit

class MainPageVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerTableViewCells()
        setBackGorundImg()
    }
    
    private func setBackGorundImg() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "MainBackGround")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func registerTableViewCells() {
        let cellIdentifiers = [
            "LogoCellTableViewCell",
            "NowPlayingTableViewCell",
            "MovieChartTableViewCell",
            "ComingSoonCellTableViewCell"
        ]
        
        cellIdentifiers.forEach { identifier in
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
}

extension MainPageVC: UITableViewDataSource {
    // TableView Section 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // TableViewCell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCellTableViewCell", for: indexPath) as! LogoCellTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingTableViewCell", for: indexPath) as! NowPlayingTableViewCell
            cell.delegate = self
            cell.configure()
            cell.onMovieBooked = { [weak self] movie in
                guard let strongSelf = self else { return }
                let storyboard = UIStoryboard(name: "ReserveViews", bundle: nil)
                if let reserveViewController = storyboard.instantiateViewController(withIdentifier: "ReserveViewController") as? ReserveViewController {
                    reserveViewController.selectedMovie = movie
                    strongSelf.show(reserveViewController, sender: nil)
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

extension MainPageVC: UITableViewDelegate {
    // TableView Height 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 260
        case 2:
            return 250
        case 3:
            return 400
        default:
            return 80
        }
    }
}

extension MainPageVC: NowPlayingTableViewCellDelegate {
    func didTapPosterImageInCell(in cell: NowPlayingCell, with movie: NowPlaying?) {
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
          detailViewController.movie = movie
            self.present(detailViewController, animated: true, completion: nil)
        }
    }
}
