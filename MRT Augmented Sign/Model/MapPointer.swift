//
//  MapPointerEnum.swift
//  MRT Augmented Sign
//
//  Created by Ahmad Fariz on 22/07/23.
//

import Foundation
import SwiftUI

struct MapPointer {
    
    @ObservedObject var viewmodel = PredictionViewModel.shared
    
    
    var url:URL?
    var jsonData:Data?
    var dict: [String: [String: String]]?
    
    init(url: URL? = nil, jsonData: Data? = nil, dict: [String : [String : String]]? = nil) {
        self.url = Bundle.main.url(forResource: "MapToExit", withExtension: "json")
        if let url = self.url {
            self.jsonData = try? Data(contentsOf: url)
            if let jsonData = self.jsonData {
                self.dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: [String: String]]
            }
        }
    }
    func pathToDestination (destination: MapDestination) ->  [String:String] {
        //guard let destination = destination else { return [:] }
        switch destination {
        case .ExitA:
            let exit = dict?["MAP to Exit A"] ?? [:]
            return exit
        case .ExitB:
            let exit = dict?["MAP to Exit B"] ?? [:]
            return exit
        case .ExitC:
            let exit = dict?["MAP to Exit C"] ?? [:]
            return exit
        case .ExitD:
            let exit = dict?["MAP to Exit D"] ?? [:]
            return exit
        }
    }
    func destinationGoal (destination:MapDestination)-> String {
        switch destination {
        case .ExitA:
            let exit = "ImageFXSudirman"
            return exit
        case .ExitB:
            let exit = "ImageGBK"
            return exit
        case .ExitC:
            let exit = "ImageIDX"
            return exit
        case .ExitD:
            let exit = "ImagePacificPlace"
            return exit
        }
    }
}


enum MapDestination: String, CaseIterable, Identifiable {
    case ExitA, ExitB, ExitC, ExitD
    
    var id: String { self.rawValue }
}
