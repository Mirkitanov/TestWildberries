//
//  FlowCoordinatorProtocol.swift
//  WildberriesTest
//
//  Created by Админ on 02.06.2022.
//

import UIKit

protocol FlowCoordinatorProtocol {
    var mainCoordinator: AppCoordinator? { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func backtoRoot()
}
