//
//  ViewControllerNest.swift
//  NavMe2
//
//  Created by Octavian on 23/07/23.
//

import SwiftUI


struct ViewControllerNest: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
        
    }
    
    typealias UIViewControllerType = ViewController
    
    
}

struct ViewControllerNest_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerNest()
    }
}
