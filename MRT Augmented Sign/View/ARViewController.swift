//
//  ViewController.swift
//  MRT Augmented Sign
//
//  Created by Ahmad Fariz on 21/07/23.
//

import UIKit
import SceneKit
import ARKit
import Vision
import SceneKit.ModelIO
import RealityKit


class ARViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate, ARCoachingOverlayViewDelegate {
    
    var resButton: UIButton?
    var sceneView: ARSCNView!
    var labelText: UILabel?
    var labelPrediction : UILabel?
    
    private var nodeList: [SCNNode] = []
    private var classificationTimer: Timer?
    private let maxNodeCount = 2
    private var isAddingNodeScheduled = false
    
    var viewModel = PredictionViewModel.shared
    
    private var _signage: SignageMRTIstora_3!
    private var signage: SignageMRTIstora_3! {
        get {
            if let model = _signage { return model }
            _signage = {
                do {
                    let configuration = MLModelConfiguration()
                    return try SignageMRTIstora_3(configuration: configuration)
                } catch {
                    fatalError("Couldn't create Inceptionv3 due to: \(error)")
                }
            }()
            return _signage
        }
    }
    
    /// A  variable containing the latest CoreML prediction
    private var identifierString = ""
    private var confidence: VNConfidence = 0.0
    private let dispatchQueueML = DispatchQueue(label: "com.exacode.dispatchqueueml") // A Serial Queue
    private var currentBuffer : CVImageBuffer?
    
    @objc func resButtonAction() {
        print("Reset")
        guard let sceneView = sceneView else {return}
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        nodeList.removeAll()
    }
    override func loadView() {
        // Create a new ARSCNView instance and set it as the view of the view controller.
        
        sceneView = ARSCNView()
        view = sceneView
        addCoachingOverlay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the UILabel
        labelPrediction = UILabel()
        labelPrediction?.text = "Placeholder Text"
        labelPrediction?.font = UIFont.systemFont(ofSize: 20)
        labelPrediction?.textColor = .white
        labelPrediction?.textAlignment = .center
        //labelText?.isHidden = true // Hide the label initially
        
        // Add the UILabel as a subview to the view hierarchy
        if let labelPrediction = labelPrediction {
            view.addSubview(labelPrediction)
            // Set constraints to position and size the label
            labelPrediction.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                labelPrediction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelPrediction.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                labelPrediction.widthAnchor.constraint(equalToConstant: 300),
                labelPrediction.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        labelText = UILabel()
        labelText?.text = "Placeholder Text"
        labelText?.font = UIFont.systemFont(ofSize: 20)
        labelText?.textColor = .white
        labelText?.textAlignment = .center
        //labelText?.isHidden = true // Hide the label initially
        
        // Add the UILabel as a subview to the view hierarchy
        if let labelText = labelText {
            view.addSubview(labelText)
            // Set constraints to position and size the label
            labelText.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                labelText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                labelText.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 30),
                labelText.widthAnchor.constraint(equalToConstant: 200),
                labelText.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        // Create the Reset button
        resButton = UIButton(type: .system)
        resButton?.setTitle("Reset", for: .normal)
        resButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        resButton?.setTitleColor(.white, for: .normal)
        resButton?.backgroundColor = .blue
        resButton?.layer.cornerRadius = 5
        resButton?.clipsToBounds = true
        
        // Add an action to the button
        resButton?.addTarget(self, action: #selector(resButtonAction), for: .touchUpInside)
        
        // Add the Reset button as a subview to the view hierarchy
        if let resButton = resButton {
            view.addSubview(resButton)
            // Set constraints to position and size the button
            resButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                resButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                resButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                resButton.widthAnchor.constraint(equalToConstant: 100),
                resButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.showsStatistics = true
        
        /// Create a new scene
        let scene = SCNScene(named: "SceneKitAssetCatalog.scnassets/AR.scn")
        sceneView.scene = scene!
        
        
        
        
        // MARK: - Start the scanning session
        self.restartSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        /// Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// Pause the view's session
        sceneView.session.pause()
    }
    
    /// The loadNodeBasedOnPrediction function loads a 3D model node based on a provided text prediction. It expects the text to be a valid filename for a USDZ file. The function first constructs a URL path using the provided text, trims whitespace and newline characters, and appends the "usdz" file extension. If the URL path cannot be created, indicating a missing file, the function returns nil.
    
    func loadNodeBasedOnPrediction(_ text: String) -> SCNNode? {
        
        // Trim whitespace and newline characters from the provided text.
        let trimmedText = viewModel.signDictionary![text]
        
        // Create a URL path for the 3D model using the provided text.
        guard let modelURL = Bundle.main.url(forResource: trimmedText, withExtension: "usdz") else {
            print("Error: 3D model not found for \(String(describing: trimmedText)).usdz")
            return nil
        }
        
        do {
            // Load the 3D model from the provided URL.
            let modelScene = try SCNScene(url: modelURL, options: nil)
            // Create an SCNNode from the loaded scene.
            let modelNode = SCNNode()
            for childNode in modelScene.rootNode.childNodes {
                modelNode.addChildNode(childNode)
            }
            
            // Scale the node appropriately (you may need to adjust this according to your model's size).
            
            //modelNode.scale = SCNVector3(1, 1, 1)
            //modelNode.rotation = SCNVector4(x: 0, y: 0.383, z: 0, w: 0.924)
            modelNode.position = SCNVector3(x: viewModel.cameraPosition!.x, y: viewModel.cameraPosition!.y+1, z: viewModel.cameraPosition!.z-4)
            
            
            return modelNode
        } catch {
            print("Error: Unable to load 3D model from \(modelURL): \(error)")
            return nil
        }
    }
    
    func createPlaneNode(with image: UIImage) -> SCNNode? {
        let planeGeo = SCNPlane(width: 1, height: 1)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = image
        planeGeo.firstMaterial = imageMaterial
        let plane = SCNNode(geometry: planeGeo)
        plane.scale = SCNVector3(1, 1,1 )
        plane.rotation = SCNVector4(x: 0, y: 0, z: 0, w: 0)
        plane.position = SCNVector3(x: viewModel.cameraPosition!.x, y: viewModel.cameraPosition!.y, z: viewModel.cameraPosition!.z-4)
        return plane
    }
    
    
    // MARK: - CoreML Vision Handling
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // Instantiate the model from its generated Swift class.
            let model = try VNCoreMLModel(for: signage.model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.classificationCompleteHandler(request: request, error: error)
            })
            
            // Crop input images to square area at center, matching the way the ML model was trained.
            request.imageCropAndScaleOption = .centerCrop
            
            // Use CPU for Vision processing to ensure that there are adequate GPU resources for rendering.
            request.usesCPUOnly = true
            
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
            return
        }
        let currentPosition = frame.camera.transform.columns.3
        viewModel.cameraPosition = currentPosition
        // Retain the image buffer for Vision processing.
        self.currentBuffer = frame.capturedImage
        classifyCurrentImage();
    }
    
    func classifyCurrentImage() {
        
        classificationTimer?.invalidate()
        classificationTimer = nil
        
        
        let orientation = CGImagePropertyOrientation(UIDevice.current.orientation)
        
        let imageRequestHandler = VNImageRequestHandler(
            cvPixelBuffer: currentBuffer!,
            orientation: orientation
        )
        
        // Run Image Request
        dispatchQueueML.async {
            do {
                // Release the pixel buffer when done, allowing the next buffer to be processed.
                defer { self.currentBuffer = nil }
                try imageRequestHandler.perform([self.classificationRequest])
            } catch {
                print(error)
            }
        }
    }
    
    func classificationCompleteHandler(request: VNRequest, error: Error?) {
        guard let results = request.results else {
            print("Unable to classify image.\n\(error!.localizedDescription)")
            return
        }
        
        // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
        let classifications = results as! [VNRecognizedObjectObservation]
        
        // Show a label for the highest-confidence result (but only above a minimum confidence threshold).
        if let bestResult = classifications.first(where: { result in result.confidence > 0.5 }),
           let label = bestResult.labels.first {
            identifierString = label.identifier
            confidence = bestResult.confidence
        } else {
            identifierString = ""
            confidence = 0
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.displayClassifiedResult()
        }
        let mapPointer = MapPointer()
        let imageName : String = mapPointer.destinationGoal(destination: viewModel.selectedGate!)
        
        
        let nodes : [SCNNode] = addNode(text:identifierString, imageName: imageName)
        for node in nodes {
            sceneView.scene.rootNode.addChildNode(node)
        }
        
        classificationTimer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.triggerClassification), userInfo: nil, repeats: false)
    }
    
    @objc private func addNode(text : String,imageName: String) -> [SCNNode]{
        // Check if the maximum node count is reached, if so, remove the oldest node.
        
        if nodeList.count >= maxNodeCount {
            for node in nodeList {
                node.removeFromParentNode()
            }
            nodeList.removeAll()
        }
        var nodes:[SCNNode]?
        // Load the node based on the prediction text.
        if let node = loadNodeBasedOnPrediction(text), let imageNode =  createPlaneNode(with: UIImage(named: imageName)!){
            
            nodeList.append(node)
            nodeList.append(imageNode)
            nodes = nodeList
        }
        
        return nodes!
    }
    
    func displayClassifiedResult() {
        
        self.labelText!.text = "this is a/an \(self.identifierString)"
        self.labelPrediction!.text = "I'm \(self.confidence * 100)% "
    }
    
    private func restartSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @objc private func triggerClassification() {
        classifyCurrentImage()
    }
    
    // MARK: - ARSCNViewDelegate
    func addCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView(frame: sceneView.bounds)
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        sceneView.addSubview(coachingOverlay)
    }
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //labelText?.isHidden = false
    }
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // The coaching overlay has been deactivated, you can remove it from the view if needed.
        coachingOverlayView.activatesAutomatically = false // To prevent the overlay from activating automatically again.
        coachingOverlayView.removeFromSuperview()
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

