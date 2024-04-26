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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        configureCollectionView()
        setupPageControl()
        fetchMovies()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 200)
        layout.minimumLineSpacing = 0
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieChartCell", bundle: nil), forCellWithReuseIdentifier: "MovieChartCell")
        collectionView.isPagingEnabled = true
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
                    let firstFiveMovies = Array(movies.prefix(5))
                    self?.movies = firstFiveMovies
                    self?.collectionView.reloadData()
                    self?.pageControl.numberOfPages = firstFiveMovies.count
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension MovieChartTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieChartCell", for: indexPath) as? MovieChartCell else {
            fatalError("Unable to dequeue MovieChartCell")
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let pageIndex = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = pageIndex
    }
}

