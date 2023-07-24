//
//  DestinationRepositorySample.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import Foundation

class DestinationRepositorySample {
    var destinations: [Destination] = []
    
    init () {
        let d1 = Destination(id: UUID(), destinationName: "Stadion Utama Gelora Bung Karno", destinationType: "Landmark", destinationExit: "Exit B", photoPath: "ImageGBK")
        let d2 = Destination(id: UUID(), destinationName: "FX Sudirman", destinationType: "Landmark", destinationExit: "Exit A", photoPath: "ImageFXSudirman")
//        let d3 = Destination(id: UUID(), destinationName: "SCBD", destinationExit: "Exit D", photoPath: "ImageSCBD")
        let d4 = Destination(id: UUID(), destinationName: "Pacific Place", destinationType: "Landmark", destinationExit: "Exit D", photoPath: "ImagePacificPlace")
//        let d5 = Destination(id: UUID(), destinationName: "IDX - Indonesia Stock Exchange", destinationExit: "Exit C", photoPath: "ImageIDX")
        
        destinations.append(d1)
        destinations.append(d2)
//        destinations.append(d3)
        destinations.append(d4)
//        destinations.append(d5)
    }
}

