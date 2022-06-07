//
//  MainCoordinatorProtocol.swift
//  WildberriesTest
//
//  Created by Админ on 02.06.2022.
//

import UIKit

protocol MainCoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
    var flowCoordinators: [FlowCoordinatorProtocol] { get set }

    func start()
}
