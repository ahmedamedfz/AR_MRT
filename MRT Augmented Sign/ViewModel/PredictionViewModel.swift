//
//  PredictionViewModel.swift
//  MRT Augmented Sign
//
//  Created by Ahmad Fariz on 22/07/23.
//

import Foundation
import SwiftUI
import SceneKit

class PredictionViewModel : ObservableObject {
    static let shared = PredictionViewModel()
    @Published var selectedGate : MapDestination?
    @Published var signDictionary : [String:String]?
    @Published var cameraPosition : simd_float4?
    @Published var imageNode : UIImage?
}
