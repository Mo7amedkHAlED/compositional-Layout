//
//  ViewController.swift
//  compositional Layout
//
//  Created by Mohamed Khaled on 22/07/2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // to make space between cells
        let layout = UICollectionViewCompositionalLayout { [weak self] (index, environment) -> NSCollectionLayoutSection? in
            return self?.createSectionFor(index: index, environment: environment)
        }
        return layout
    }
    
    func createSectionFor(index: Int ,environment : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
        case 0 :
            return createFirstSection()
        case 1 :
            return createSecondSection()
        case 2 :
            return createThirdSection()
        default :
            return createFirstSection()
        }
    }
    // make design for each section
    func createFirstSection() -> NSCollectionLayoutSection {
        ///UICollectionViewCompositionalLayout content from
        ///Item
        ///Group
        ///Section
        let inset: CGFloat = 2.5
        // MARK: - Make Item
        let itemSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension:NSCollectionLayoutDimension.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // to make space between cells
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        // MARK: - Make Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: NSCollectionLayoutDimension.fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
        // MARK: - Make section
        let section = NSCollectionLayoutSection(group: group)
        // to make ScrollingBehavior
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createSecondSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 0.5
        // MARK: - Make Item
        let itemSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(0.4), heightDimension:NSCollectionLayoutDimension.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // to make space between cells
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        // MARK: - Make Group
        // .fractionalWidth(0.9) to show 3 cell
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),heightDimension: NSCollectionLayoutDimension.fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        // MARK: - Supplementary for view of header name
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        // MARK: - Make section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        // to make ScrollingBehavior
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func createThirdSection() -> NSCollectionLayoutSection {
        let inset: CGFloat = 0.5
        // MARK: - Make Item
        let smallItemSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1), heightDimension:NSCollectionLayoutDimension.fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let largeItemSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(0.5), heightDimension:NSCollectionLayoutDimension.fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // MARK: - Make Group
        // .fractionalWidth(0.9) to show 3 cell
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),heightDimension: NSCollectionLayoutDimension.fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [smallItem])
        
        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: NSCollectionLayoutDimension.fractionalHeight(0.5))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [largeItem, verticalGroup, verticalGroup])
        
        // MARK: - Supplementary for view of header name
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        // MARK: - Make section
        let section = NSCollectionLayoutSection(group: horizontalGroup)
        section.boundarySupplementaryItems = [header]
        // to make ScrollingBehavior
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}

extension ViewController : collectionViewType {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 2 ? 15 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        // to make random color for each cell
        cell.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
        return cell
    }
    // This method is used to provide the collection view with reusable supplementary views, such as section headers or footers.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView
        else {
            return UICollectionReusableView()
        }
        switch indexPath.section {
        case 1 :
            view.title = "Recently Viewed"
        case 2 :
            view.title = "Browse by category"
        default :
            view.title = nil
        }
        //view.title = indexPath.section == 1 ? "Recently Viewed " : "Browse by category"
        return view
    }
    
}
