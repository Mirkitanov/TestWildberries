//
//  AppCoordinator.swift
//  WildberriesTest
//
//  Created by Админ on 02.06.2022.
//

import UIKit

class AppCoordinator: MainCoordinatorProtocol {
    
    /// CheapList tab bar navigation
    lazy var cheapListCollectionNavigationController: UINavigationController = {
        var navigationController = UINavigationController()
        let title = "Актуальные перелеты"
        let image = UIImage(systemName: "house.fill")
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return navigationController
    }()
    
    /// Info tab bar navigation
    lazy var infoNavigationController: UINavigationController = {
        var navigationController = UINavigationController()
        let title = "Информация"
        let image = UIImage(systemName: "person.fill")
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return navigationController
    }()
    
    var tabBarController: UITabBarController
    var flowCoordinators = [FlowCoordinatorProtocol]()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        flowCoordinators = [
            CheapListCollectionCoordinator(navigationController: cheapListCollectionNavigationController, mainCoordinator: self),
            InfoCoordinator(navigationController: infoNavigationController, mainCoordinator: self)
        ]
        
        for coordinator in flowCoordinators {
            coordinator.start()
        }
        
        // Add tab bars controllers
        tabBarController.viewControllers = [infoNavigationController, cheapListCollectionNavigationController]
    }
}

