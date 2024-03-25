//
//  ViewController.swift
//  TheMovieDBApp
//
//  Created by John on 25/03/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - CodeView
extension ViewController: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .green
    }
}
