//
//  NewViewController.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/23/24.
//

import UIKit
/*
// Section별로 다른 Layout을 사용
enum SectionLayoutKind: Int, CaseIterable {
    case list, grid5, grid3  // rawValue가 각각 0,1,2로 지정됨

    // createLayout()에서 호출되며, 1개 row에 몇 개의 item이 들어갈지 설정함
    var columnCount: Int {
        switch self {
        case .grid3:
            return 3
        case .grid5:
            return 5
        case .list:
            return 1
        }
    }
}

class DistinctSectionsViewController: UIViewController {
    var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>! = nil
    var collectionView: UICollectionView! = nil

    func configureDataSource() {
        // 1️⃣ Cell 등록
        // 2개 종류의 Cell Type을 사용 (ListCell / TextCell)
        
        let listCellRegistration = UICollectionView.CellRegistration<ListCell, Int> { (cell, indexPath, identifier) in
            cell.label.text = "\(identifier)"
        }

        let textCellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
            cell.label.text = "\(identifier)"
            //...
        }
        
        // 2️⃣ DiffableDataSource 생성
        // ✅ 주의 - dataSource 프로퍼티를 2개로 나누지 않음!
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // 일반적인 dataSource를 사용할 때처럼 화면에 보이는 Cell의 개수만큼 호출됨
            // ✅ Setion이 .list이면 ListCell 타입, .grid5, .grid3이면 TextCell 타입으로 dequeue
            return SectionLayoutKind(rawValue: indexPath.section)! == .list ?
            collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: identifier) :
            collectionView.dequeueConfiguredReusableCell(using: textCellRegistration, for: indexPath, item: identifier)
        }

        // 3️⃣ snapshot 생성 및 적용
        // initial data
        let itemsPerSection = 10
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>()
        SectionLayoutKind.allCases.forEach {
            snapshot.appendSections([$0])
            // ✅ Section마다 다른 Item을 지정 - Section1은 1~9, Section2는 10~19, Section3은 20~29로 구성
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

func createLayout() -> UICollectionViewLayout {
    // ✅ sectionProvider를 통해 CollectionView 관련 정보를 받아서 활용함 (cellProvider와 비슷)
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

        guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }  // section의 rawValue로 column을 찾아둠
        let columns = sectionLayoutKind.columnCount  // ✅ Section 종류별로 column 개수가 다름

        // The group auto-calculates the actual item width to make
        // the requested number of columns fit, so this widthDimension is ignored.
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(0.2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns) // ✅ count의 매개변수로 전달됨

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    return layout
}
*/
