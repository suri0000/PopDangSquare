//
//  DetailViewController.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/22/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollView: UICollectionView!
    
//    let movieDetail = DetailData.detail
//    let reviewDetail = ReviewData.reviews
   
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
        NetworkManager.fetchMovies { _, _ in
            
        }
        
        // Apply initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionType.ItemType>()
        snapshot.appendSections([.detail, .review])
//        snapshot.appendItems([.detail(DetailData)], toSection: .detail)
//        snapshot.appendItems([.detail(DetailData.detail[indexPath.section])], toSection: .detail)
        snapshot.appendItems([.detail(DetailData.init(movieNm: "범죄도시7", movieNmEn: "BeomjoeCity", prdtYear: "2024.05.05"))], toSection: .detail)
        snapshot.appendItems([.review(ReviewData.init(detailStars: "⭐️⭐️⭐️⭐️", detailDate: "220108", detailReview: "내가 살면서 이런 영화 다시 보나 봐라. 진짜로. 근데 재밌음.. 사실 재미있었다. 나만 보고싶어서 평점 이렇게 남겨봅니다. 하하호호 제작진들 놀랬겠죠? 후핫"))], toSection: .review)
        datasource.apply(snapshot)
        //Layout
        detailCollView.collectionViewLayout = layout()
        
        //        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupCollectionView() {
        detailCollView.register(UINib(nibName: "DetailViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailViewCell")
        detailCollView.register(UINib(nibName: "DetailReviewCell", bundle: nil), forCellWithReuseIdentifier: "DetailReviewCell")
        
        detailCollView.dataSource = datasource
        // Add collectionView constraints or setup its frame
    }
    
    private func setupDataSource() {
        datasource = UICollectionViewDiffableDataSource<SectionType, SectionType.ItemType>(collectionView: detailCollView, cellProvider: {
            collectionView, indexPath, item in
            
            switch self.datasource.snapshot().sectionIdentifiers[indexPath.section] {
                
            case .detail:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as? DetailViewCell,
//                      case let .detail(detailItem) = item //
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
        
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)) //estimated = 사이즈가 재각각이면 큰것에 따르게끔
        //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //count없는것은 유동적으로 사이즈가 맞춰지길 원할때 사용.
        //        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
                section.interGroupSpacing = 20
        
        //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        //        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        //        section.boundarySupplementaryItems = [header]
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
    
    /*
    
    let movieDetail = DetailData.detail
    let reviewDetail = ReviewData.reviews
    
    enum Section: CaseIterable {
        case detailMain
        case review
        
        var title: String {
            switch self {
            case .detailMain: return "영화"
            case .review: return "실관람평"
            }
        }
    }
    
    typealias Item = DetailData
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollView.register(UINib(nibName: DetailViewCell.className, bundle: nil), forCellWithReuseIdentifier: DetailViewCell.cellId)
        detailCollView.register(UINib(nibName: DetailReviewCell.className, bundle: nil), forCellWithReuseIdentifier: DetailReviewCell.cellId)
        
        
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: detailCollView, cellProvider: {
            collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCell", for: indexPath) as? DetailViewCell else {
                return DetailViewCell()
            }
            
            cell.configure(item)

            return cell
        })
        
        
//        datasource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
//            guard let header = self.detailCollView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeaderReusableView", for: indexPath) as? DetailHeaderReusableView else {
//                return nil
//            }
//            
//         
//            let allSections = Section.allCases
//            let section = allSections[indexPath.section]
//            header.configure(section.title)
//            return header
//        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.detailMain, .review])
        //각 섹션이 뭔지 좀 더 명활하게 하기 위해 위에꺼 일단 씀
        
//        snapshot.appendSections(Section.allCases)
        
        //[section, [item]][section, [item]]
        snapshot.appendItems(movieDetail, toSection: .detailMain)
        snapshot.appendItems(reviewDetail, toSection: .review)

        datasource.apply(snapshot)
        
        
        //Layout
        detailCollView.collectionViewLayout = layout()
        
//        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)) //estimated = 사이즈가 재각각이면 큰것에 따르게끔
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //count없는것은 유동적으로 사이즈가 맞춰지길 원할때 사용.
//        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
//        section.interGroupSpacing = 20
        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        section.boundarySupplementaryItems = [header]
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    
    
    
}
     */

