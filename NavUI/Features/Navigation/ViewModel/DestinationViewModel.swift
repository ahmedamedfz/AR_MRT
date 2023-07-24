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
    var streetDestinationList = StreetRepositorySample()
    
    // Properties to store the filtered destinations
    @Published var filteredDestinations: [Destination] = []
    @Published var filteredExitGates: [Exit] = []
    @Published var filteredStreetDestinations: [Destination] = []
    
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
    
    var streetDestinations: [Destination] {
        var exit = [] as [Destination]
        for ex in streetDestinationList.streets {
            exit.append(ex)
        }
        return exit
    }
    
    func updateFilteredDestinations(with searchText: String) {
        filteredDestinations = destinations.filter { destination in
            destination.destinationName.localizedCaseInsensitiveContains(searchText)
        }

        filteredExitGates = exitGates.filter { exit in
            exit.name.localizedCaseInsensitiveContains(searchText)
        }

        filteredStreetDestinations = streetDestinations.filter { destination in
            destination.destinationName.localizedCaseInsensitiveContains(searchText)
        }
    }
}
