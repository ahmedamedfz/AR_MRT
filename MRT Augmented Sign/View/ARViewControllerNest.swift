//
//  ViewControllerNest.swift
//  MRT Augmented Sign
//
//  Created by Ahmad Fariz on 22/07/23.
//

import SwiftUI

struct ARViewControllerNest: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ARViewController
    
    func makeUIViewController(context: Context) -> ARViewController {
        ARViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        
    }
}

