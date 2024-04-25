//
//  DetailViewController.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/22/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollView: UICollectionView!
    
    enum SectionType: Int, CaseIterable {
        case detail, review
        
        var columnCount: Int {
            switch self {
            case .detail:
                return DetailData.detail.count
            case .review:
                return ReviewData.reviews.count
            }
        }
        
        var title: String {
            switch self {
            case .detail: return "Moview Detail"
            case .review: return "Reviews"
            }
        }
        enum ItemType: Hashable{
            case detail(DetailData)
            case review(ReviewData)
        }
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var datasource: UICollectionViewDiffableDataSource<SectionType, SectionType.ItemType>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        //        NetworkManager.fetchMovies { _, _ in
        //
        //        }
        
    }
}
extension DetailViewController {
    private func setupCollectionView() {

        
        detailCollView.register(UINib(nibName: "DetailViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailViewCell")
        detailCollView.register(UINib(nibName: "DetailReviewCell", bundle: nil), forCellWithReuseIdentifier: "DetailReviewCell")
        detailCollView.register(UINib(nibName: "DetailHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeaderReusableView")
        detailCollView.dataSource = datasource
        
        //Layout
        detailCollView.collectionViewLayout = layout()
    }
    
    private func setupDataSource() {
        datasource = UICollectionViewDiffableDataSource<SectionType, SectionType.ItemType>(collectionView: detailCollView, cellProvider: {
            collectionView, indexPath, item in
            
            switch self.datasource.snapshot().sectionIdentifiers[indexPath.section] {
                
            case .detail:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as? DetailViewCell,
                      case let .detail(detailItem) = item
                else {
                    return DetailViewCell()
                }
                cell.configure(detailItem)
                return cell
                
            case .review:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailReviewCell", for: indexPath) as? DetailReviewCell,
                      case let .review(reviewItem) = item
                else {
                    return DetailReviewCell()
                }
                cell.configure(reviewItem)
                return cell
            }
        })
        
        //Section Header
        datasource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeaderReusableView", for: indexPath) as? DetailHeaderReusableView else {
                return nil
            }
            
            let allSections = SectionType.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
            return header
        }
        
        // Apply initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionType.ItemType>()
        snapshot.appendSections([.detail, .review])
        // detail이미지는 터치에 반응한 녀석으로 띄우게 해야됨.
        snapshot.appendItems(DetailData.detail.map { SectionType.ItemType.detail($0) }, toSection: .detail)
        snapshot.appendItems(ReviewData.reviews.map { SectionType.ItemType.review($0) }, toSection: .review)
        datasource.apply(snapshot, animatingDifferences: true)
    }
}

extension DetailViewController {
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
        section.interGroupSpacing = 5
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
