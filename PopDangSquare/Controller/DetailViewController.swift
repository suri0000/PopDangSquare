//
//  DetailViewController.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/22/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollView: UICollectionView!
    
    
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
        
        snapshot.appendSections(Section.allCases)
        
        //[section, [item]][section, [item]]
        snapshot.appendItems(movieDetail, toSection: .detailMain)

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
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
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


