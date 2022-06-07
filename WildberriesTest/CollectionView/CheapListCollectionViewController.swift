//
//  CheapListCollectionViewController.swift
//  WildberriesTest
//
//  Created by Админ on 07.06.2022.
//

import UIKit

final class CheapListCollectionViewController: UIViewController {
    
    weak var flowCoordinator: CheapListCollectionCoordinator?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CheapListCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.backgroundColor = .white
        collectionView.register(
            CatalogueHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "headerID")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setupViews() {
        title = "Актуальные перелеты"
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension CheapListCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return JsonParsingDecoder.flightStorage.tableModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JsonParsingDecoder.flightStorage.tableModel[section].flightes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CheapListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CheapListCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: CatalogueHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID", for: indexPath) as! CatalogueHeaderCollectionReusableView
            
            headerView.title = "Проверено Wildberries"
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

extension CheapListCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    var sideInset: CGFloat { return 12 }
    var middleInset: CGFloat { return 10 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - sideInset * 2, height: 150)
        }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: sideInset, bottom: 40, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let flightCell = cell as? CheapListCollectionViewCell else { return }
        flightCell.flight = JsonParsingDecoder.flightStorage.tableModel[indexPath.section].flightes[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let flight = JsonParsingDecoder.flightStorage.tableModel[indexPath.section].flightes[indexPath.item]
        
        flowCoordinator?.gotoDetails(flightToDetails: flight)
    }
}

