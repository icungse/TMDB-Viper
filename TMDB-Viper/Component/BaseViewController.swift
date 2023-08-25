//
//  BaseViewController.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

    private let spinner = SpinnerViewController()
    @Published var isLoading = true
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerObserver()
    }
}

extension BaseViewController {
    private func registerObserver() {
        cancellable = $isLoading.sink { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.showLoading()
        }
    }
    
    private func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            if isLoading {
                addChild(spinner)
                spinner.view.frame = view.frame
                view.addSubview(spinner.view)
                spinner.didMove(toParent: self)
            } else {
                spinner.willMove(toParent: nil)
                spinner.view.removeFromSuperview()
                spinner.removeFromParent()
            }
        }
    }
}
