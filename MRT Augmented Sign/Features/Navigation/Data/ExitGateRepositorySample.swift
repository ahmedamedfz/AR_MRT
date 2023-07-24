//
//  ExitGateRepositorySample.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import Foundation

class ExitGateRepositorySample{
    var exitGates: [Exit] = []
    
    init(){
        let e1 = Exit(id: UUID(), name: "Pintu Keluar A", type: "Exit Gate", destination:
//                        [Destination(id: UUID(), destinationName: "Stadion Utama Gelora Bung Karno", destinationExit: "Exit B", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Jl. Pintu Satu Senayan", destinationExit: "Exit B", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "The Sultan Hotel", destinationExit: "Exit B", photoPath: "ImageGBK")]
                      ["Stadion GBK", "Jl. Pintu Satu Senayan"]
        )
        let e2 = Exit(id: UUID(), name: "Pintu Keluar B", type: "Exit Gate", destination:
//                        [Destination(id: UUID(), destinationName: "FX Sudirman", destinationExit: "Exit B", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Halte TJ Gelora Bung Karno", destinationExit: "Exit B", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Jl. Pintu 1 Senayan", destinationExit: "Exit B", photoPath: "ImageGBK")]
                      ["FX Sudirman", "Jl. Pintu 1 Senayan"]
        )

        let e3 = Exit(id: UUID(), name: "Pintu Keluar C", type: "Exit Gate",destination:
//                        [Destination(id: UUID(), destinationName: "Bursa Efek Indonesia", destinationExit: "Exit C", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Mandiri Tower", destinationExit: "Exit C", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Pacific Place", destinationExit: "Exit C", photoPath: "ImageGBK")]
                      ["Bursa Efek Indonesia", "Pacific Place"]

        )
        let e4 = Exit(id: UUID(), name: "Pintu Keluar D", type: "Exit Gate",destination:
//                        [Destination(id: UUID(), destinationName: "SCBD", destinationExit: "Exit D", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Polda Metro Jaya", destinationExit: "Exit D", photoPath: "ImageGBK"),
//                         Destination(id: UUID(), destinationName: "Halte TJ Polda Metro Jaya", destinationExit: "Exit D", photoPath: "ImageGBK")]
                      ["SCBD", "Polda Metro Jaya"]

        )
        
        exitGates.append(e1)
        exitGates.append(e2)
        exitGates.append(e3)
        exitGates.append(e4)
    }
    
}
