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
    case detail, review, actor, trailer
    
    var columnCount: Int {
      switch self {
        case .detail:
          return 1
        case .review:
          return ReviewData.reviews.count
        case .actor:
          return ActorData.actors.count
        case .trailer:
          return TrailerData.trailers.count
      }
    }
    
    var title: String {
      switch self {
        case .detail: return "Moview Detail"
        case .review: return "Reviews"
        case .actor: return "Actors"
        case .trailer: return "Trailers"
      }
    }
    
    enum ItemType: Hashable {
      case detail(DetailData)
      case review(ReviewData)
      case actor(ActorData)
      case trailer(TrailerData)
    }
  }
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  var datasource: UICollectionViewDiffableDataSource<SectionType, SectionType.ItemType>!
  
  var movie: NowPlaying?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    fetchMoviePlot()
    setupDataSource()
    
  }
  
  func fetchMoviePlot() {
    guard let movieOverview = movie?.overview else { return }
    
    if movieOverview == "" {
      DetailData.detail[0].story = "줄거리를 제공하지 않습니다. 죄송합니다."
    } else {
      DetailData.detail[0].story = movieOverview
    }
  }

}

extension DetailViewController {
  private func setupCollectionView() {
    detailCollView.register(UINib(nibName: "DetailViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailViewCell")
    detailCollView.register(UINib(nibName: "DetailReviewCell", bundle: nil), forCellWithReuseIdentifier: "DetailReviewCell")
    detailCollView.register(UINib(nibName: "DetailActorCell", bundle: nil), forCellWithReuseIdentifier: "DetailActorCell")
    detailCollView.register(UINib(nibName: "DetailTrailerCell", bundle: nil), forCellWithReuseIdentifier: "DetailTrailerCell")
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
          
        case .actor:
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailActorCell", for: indexPath) as? DetailActorCell,
                case let .actor(actorItem) = item
          else {
            return DetailActorCell()
          }
          cell.configure(actorItem)
          return cell
          
        case .trailer:
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTrailerCell", for: indexPath) as? DetailTrailerCell,
                case let .trailer(trailerItem) = item
          else {
            return DetailTrailerCell()
          }
          cell.configure(trailerItem)
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
    snapshot.appendSections([.detail, .review, .actor, .trailer])
    // detail이미지는 터치에 반응한 녀석으로 띄우게 해야됨.
    snapshot.appendItems(DetailData.detail.map { SectionType.ItemType.detail($0) }, toSection: .detail)
    snapshot.appendItems(ReviewData.reviews.map { SectionType.ItemType.review($0) }, toSection: .review)
    snapshot.appendItems(ActorData.actors.map { SectionType.ItemType.actor($0) }, toSection: .actor)
    snapshot.appendItems(TrailerData.trailers.map { SectionType.ItemType.trailer($0) }, toSection: .trailer)
    datasource.apply(snapshot, animatingDifferences: true)
  }
}


extension DetailViewController {
  private func layout() -> UICollectionViewCompositionalLayout {
    
    let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
      switch SectionType(rawValue: sectionIndex)! {
        case .detail:
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
          
          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .groupPaging
          section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
          section.interGroupSpacing = 5
          
          let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
          section.boundarySupplementaryItems = [header]
          
          return section
          
        case .review:
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.3))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
          
          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .groupPaging
          section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 1, bottom: 0, trailing: 1)
          //                section.interGroupSpacing = 5
          
          let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
          section.boundarySupplementaryItems = [header]
          
          return section
          
        case .actor:
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.3))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalWidth(0.3))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
          
          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .groupPaging
          section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
          section.interGroupSpacing = 5
          
          let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
          section.boundarySupplementaryItems = [header]
          
          return section
          
        case .trailer:
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
          
          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .groupPaging
          section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
          section.interGroupSpacing = 5
          
          let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
          let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
          section.boundarySupplementaryItems = [header]
          
          return section
      }
    }
    
    return layout
  }
}
