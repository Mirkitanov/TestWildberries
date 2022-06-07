//
//  InfoCoordinator.swift
//  WildberriesTest
//
//  Created by Админ on 02.06.2022.
//

import UIKit

class InfoCoordinator: FlowCoordinatorProtocol {
    
    var navigationController: UINavigationController
    weak var mainCoordinator: AppCoordinator?

    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }

    func start() {
    
        let infoVC = InfoViewController()
        
        infoVC.flowCoordinator = self
        
        navigationController.pushViewController(infoVC, animated: true)
    }
    
    func backtoRoot() {
        guard navigationController.viewControllers.count > 0 else { return }

        navigationController.popToRootViewController(animated: true)
    }
}

