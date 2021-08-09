//
//  DemoModuleAssembly.swift
//  PresenterDemo
//
//  Created by nikita on 08.08.2021.
//

import EasyDi

class DemoModuleAssembly: Assembly {
    var viewController: UIViewController {
        return define(init: self.buildViewController()) {
            $0.presenter = self.presenter($0)
            return $0
        }
    }
}

private extension DemoModuleAssembly {
    func presenter(_ view: DemoView) -> DemoPresenter {
        define(init: DemoPresenterImpl()) {
            $0.view = view
            $0.stringsService = self.stringsService
            return $0
        }
    }
    
    var stringsService: StringsService {
        define(init: StringsServiceImpl())
    }
    
    func buildViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        return storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    var router: DemoRouter {
        define(init: DemoRouterImpl())
    }
    
    var registerService: RegisterService {
        define(init: RegisterServiceImpl())
    }
}
