//
//  UIViewController+Loading.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import UIKit

extension UIViewController {
    
    //MARK:- Show Loader
    @discardableResult
    func showLoader()-> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        
        present(alert, animated: true, completion: nil)
        return alert
    }
}
