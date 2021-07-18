//
//  RootModuleAssembly.swift
//  segues_presentartion
//
//  Created by nikita on 18.07.2021.
//

import EasyDi

class RootModuleAssembly: Assembly {
    private lazy var servicesAssembly: ServicesAssembly = context.assembly()
    private lazy var blueAssembly: BlueModuleAssembly = context.assembly()
    
    var viewController: ViewController {
        define(init: (ViewControllersFactory().viewController(identifier: "ViewController") as ViewController)) {
            $0.service = self.servicesAssembly.service1
            $0.blueAssembly = self.blueAssembly
            return $0
        }
    }
}
