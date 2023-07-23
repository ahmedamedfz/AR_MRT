//
//  ViewController.swift
//  NavMe2
//
//  Created by Octavian on 22/07/23.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    let boxAnchor = try! Experience.loadExit()
    var imageAnchorToEntity: [ARImageAnchor: AnchorEntity] = [:]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the box anchor to the scene
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        arView.scene.anchors.append(boxAnchor)
        arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            anchors.compactMap { $0 as? ARImageAnchor }.forEach {
                let anchorEntity = AnchorEntity()
                for entity in boxAnchor.arrowEntities {
                    let modelEntity = entity
                    anchorEntity.addChild(modelEntity)
                }
                
                arView.scene.addAnchor(anchorEntity)
                anchorEntity.transform.matrix = $0.transform
                imageAnchorToEntity[$0] = anchorEntity
            }
        }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            anchors.compactMap { $0 as? ARImageAnchor }.forEach {
                let anchorEntity = imageAnchorToEntity[$0]
                anchorEntity?.transform.matrix = $0.transform
            }
        }
    
}
