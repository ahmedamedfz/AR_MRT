//
//  ContentView.swift
//  Navigation_MRT
//
//  Created by Octavian on 18/07/23.
//

import SwiftUI
import RealityKit
import Combine

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    var subscriptions: [AnyCancellable] = []
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        arView.scene.subscribe(to: SceneEvents.DidAddEntity.self) { [weak boxAnchor] event in
            guard let anchor = boxAnchor, anchor.isActive else { return }
            
            for entity in anchor.children {
                for animation in entity.availableAnimations {
                    entity.playAnimation(animation.repeat())
                }
            }
        }
        .store(in: &arView.subscribers)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
