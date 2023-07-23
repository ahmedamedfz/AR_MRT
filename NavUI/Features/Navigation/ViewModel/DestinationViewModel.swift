//
//  DestinationViewModel.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import Foundation

class DestinationViewModel: ObservableObject, Identifiable {
    var destinationList = DestinationRepositorySample()
    var exitGateList = ExitGateRepositorySample()
    
    var destinations: [Destination] {
        var destination = [] as [Destination]
        for dest in destinationList.destinations {
            destination.append(dest)
        }
        return destination
    }
    
    var exitGates: [Exit] {
        var exit = [] as [Exit]
        for e in exitGateList.exitGates {
            exit.append(e)
        }
        return exit
    }
}
