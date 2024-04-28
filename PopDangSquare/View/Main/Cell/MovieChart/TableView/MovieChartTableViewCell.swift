//
//  MovieChartTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class MovieChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageControl: UIPageControl!
    var movies: [Popular] = [] // 영화 데이터를 저장할 배열
    var autoScrollTimer: Timer? // 자동 스크롤을 위한 타이머
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        configureCollectionView()
        setupPageControl()
        fetchMovies()
        startAutoScroll()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 220)
        layout.minimumLineSpacing = 0
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieChartCell", bundle: nil), forCellWithReuseIdentifier: "MovieChartCell")
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
    }
    
    private func setupPageControl() {
        let leftMargin: CGFloat = -9
        let topMargin: CGFloat = 30
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = movies.count
        pageControl.currentPage = 0
        pageControl.tintColor = .red
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        
        contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: leftMargin),
            pageControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topMargin),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            pageControl.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func fetchMovies() {
        PopularManager.shared.fetchMovies { [weak self] (movies, error) in
            DispatchQueue.main.async {
                if let movies = movies {
                    // 영화 목록을 랜덤하게 섞은 후, 첫 5개의 영화를 선택합니다.
                    let randomFiveMovies = Array(movies.shuffled().prefix(5))
                    self?.movies = randomFiveMovies
                    self?.collectionView.reloadData()
                    self?.pageControl.numberOfPages = randomFiveMovies.count
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    
    // 자동 스크롤 시작
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    // 다음 아이템으로 스크롤
    @objc private func scrollToNextItem() {
        let currentPageIndex = pageControl.currentPage
        let nextPageIndex = currentPageIndex + 1
        
        if nextPageIndex < movies.count {
            collectionView.scrollToItem(at: IndexPath(item: nextPageIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = nextPageIndex
        } else {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = 0
        }
    }
    
    // 타이머 해제
    deinit {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
}

// MARK: - UICollectionViewDataSource
extension MovieChartTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieChartCell", for: indexPath) as? MovieChartCell else {
            fatalError("Unable to dequeue MovieCollectionViewCell.")
        }
        
        // Configure the cell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieChartTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the cell size
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Set the spacing between rows
        return 0
    }
}

// MARK: - UIScrollViewDelegate
extension MovieChartTableViewCell: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // User begins dragging, stop the timer
        autoScrollTimer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // User ends dragging, restart the timer
        startAutoScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Update page control when user manually scrolls
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // Update page control when automatic scrolling occurs
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}


