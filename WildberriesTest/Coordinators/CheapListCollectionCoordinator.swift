//
//  CheapListCollectionCoordinator.swift
//  WildberriesTest
//
//  Created by Админ on 07.06.2022.
//

import UIKit

class CheapListCollectionCoordinator: FlowCoordinatorProtocol {
    
    var navigationController: UINavigationController
    weak var mainCoordinator: AppCoordinator?

    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }

    func start() {
    
        let cheaperListCollectionVC = CheapListCollectionViewController()
        
        cheaperListCollectionVC.flowCoordinator = self
        
        navigationController.pushViewController(cheaperListCollectionVC, animated: true)
    }
    
    func backtoRoot() {
        guard navigationController.viewControllers.count > 0 else { return }

        navigationController.popToRootViewController(animated: true)
    }
    
        func gotoDetails(flightToDetails: Flight) {
            
            let flightDetailsViewController = FlightDetailsViewController(flightToDetails: flightToDetails)
            
            flightDetailsViewController.flowCoordinator = self
            
            navigationController.pushViewController(flightDetailsViewController, animated: true)
        }
}
