//
//  StreetRepositorySample.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 24/07/23.
//

import Foundation

class StreetRepositorySample {
    var streets: [Destination] = []
    
    init () {
        let d1 = Destination(id: UUID(), destinationName: "Jl. Pintu Satu Senayan", destinationType: "Street", destinationExit: "Exit A", photoPath: "ImageJlPintu1Senayan")
        let d2 = Destination(id: UUID(), destinationName: "Jl. Jendral Sudirman", destinationType: "Street", destinationExit: "Exit A", photoPath: "ImageJlSudirman")
//        let d3 = Destination(id: UUID(), destinationName: "SCBD", destinationExit: "Exit D", photoPath: "ImageSCBD")
//        let d4 = Destination(id: UUID(), destinationName: "Pacific Place", destinationType: "Landmark", destinationExit: "Exit D", photoPath: "ImagePacificPlace")
//        let d5 = Destination(id: UUID(), destinationName: "IDX - Indonesia Stock Exchange", destinationExit: "Exit C", photoPath: "ImageIDX")
        
        streets.append(d1)
        streets.append(d2)
//        destinations.append(d3)
//        destinations.append(d4)
//        destinations.append(d5)
    }
}

