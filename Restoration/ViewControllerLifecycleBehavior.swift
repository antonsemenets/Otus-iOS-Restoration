//
//  ViewControllerLifeCycleBehavior.swift
//  iOSAppLifeCycle
//
//  Created by Антон Семенец on 09/09/2019.
//  Copyright © 2019 Anton Semenets. All rights reserved.
//

import UIKit

protocol ViewControllerLifecycleBehavior {
    func afterLoading(viewController: UIViewController)
    
    func beforeAppearing(viewController: UIViewController)
    
    func afterAppearing(viewController: UIViewController)
    
    func beforeDisappearing(viewController: UIViewController)
    
    func afterDisappearing(viewController: UIViewController)
    
    func beforeLayingOutSubviews(viewController: UIViewController)
    
    func afterLayingOutSubviews(viewController: UIViewController)
}

extension ViewControllerLifecycleBehavior {
    func afterLoading(viewController: UIViewController) {}
    
    func beforeAppearing(viewController: UIViewController) {}
    
    func afterAppearing(viewController: UIViewController) {}
    
    func beforeDisappearing(viewController: UIViewController) {}
    
    func afterDisappearing(viewController: UIViewController) {}
    
    func beforeLayingOutSubviews(viewController: UIViewController) {}
    
    func afterLayingOutSubviews(viewController: UIViewController) {}
}

struct HideNavigationBarBehavior: ViewControllerLifecycleBehavior {
    func beforeAppearing(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func beforeDisappearing(viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

class TimerBehavior: ViewControllerLifecycleBehavior {
    var timer = Timer()
    
    func afterAppearing(viewController: UIViewController) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            print(Date())
        })
    }
    
    func beforeDisappearing(viewController: UIViewController) {
        timer.invalidate()
    }
}


class TabBarColorBehavior: ViewControllerLifecycleBehavior {
    
    
    func beforeAppearing(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = .black
        viewController.view.backgroundColor = .black
    }
    
    func beforeDisappearing(viewController: UIViewController) {
        viewController.navigationController?.navigationBar.barStyle = .default
        viewController.view.backgroundColor = .white
    }
}

extension UIViewController {

    /*
     Add behaviors to be hooked into this view controller’s lifecycle.
     
     This method requires the view controller’s view to be loaded, so it’s best to call
     in `viewDidLoad` to avoid it being loaded prematurely.
     
     - parameter behaviors: Behaviors to be added.
     */
    func addBehaviors(behaviors: [ViewControllerLifecycleBehavior]) {
        let behaviorViewController = LifecycleBehaviorViewController(behaviors: behaviors)
        
        addChild(behaviorViewController)
        view.addSubview(behaviorViewController.view)
        behaviorViewController.didMove(toParent: self)
    }
    
    private final class LifecycleBehaviorViewController: UIViewController {
        private let behaviors: [ViewControllerLifecycleBehavior]
        
        // MARK: - Initialization
        
        init(behaviors: [ViewControllerLifecycleBehavior]) {
            self.behaviors = behaviors
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.isHidden = true
            
            applyBehaviors { behavior, viewController in
                behavior.afterLoading(viewController: viewController)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.beforeAppearing(viewController: viewController)
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.afterAppearing(viewController: viewController)
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.beforeDisappearing(viewController: viewController)
            }
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.afterDisappearing(viewController: viewController)
            }
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            
            applyBehaviors { behavior, viewController in
                behavior.beforeLayingOutSubviews(viewController: viewController)
            }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            applyBehaviors { behavior, viewController in
                behavior.afterLayingOutSubviews(viewController: viewController)
            }
        }
        
        // MARK: - Private
        
        private func applyBehaviors( body: (_ behavior: ViewControllerLifecycleBehavior, _ viewController: UIViewController) -> Void) {
            guard let parentViewController = parent else { return }
            
            for behavior in behaviors {
                body(behavior, parentViewController)
            }
        }
    }
}
