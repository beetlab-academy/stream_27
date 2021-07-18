//
//  BlueModuleAssembly.swift
//  segues_presentartion
//
//  Created by nikita on 18.07.2021.
//

import EasyDi

class BlueModuleAssembly: Assembly {
    var viewController: BlueViewController {
        define(init: (ViewControllersFactory().viewController(identifier: "BlueViewController")))
    }
}
