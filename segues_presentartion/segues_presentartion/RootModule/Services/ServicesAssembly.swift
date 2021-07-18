//
//  ServicesAssembly.swift
//  segues_presentartion
//
//  Created by nikita on 18.07.2021.
//

import EasyDi

class ServicesAssembly: Assembly {
    var service1: Service1 {
        define(init: Service1Impl())
    }
}
