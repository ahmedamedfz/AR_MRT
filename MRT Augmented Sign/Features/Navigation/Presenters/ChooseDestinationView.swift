//
//  ChooseDestinationView.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import SwiftUI

struct ChooseDestinationView: View {
    @ObservedObject var destinationViewModel: DestinationViewModel
    @State private var isShowExit: [Bool] // Use an array of Bool to track the sheet state for each item
    @State private var isShowDetailExit: [Bool] // Use an array of Bool to track the sheet state for each item
    @State private var searchText: String = ""
    
    init(destinationViewModel: DestinationViewModel) {
        self.destinationViewModel = destinationViewModel
        // Initialize the arrays with false for each item in the loop
        _isShowExit = State(initialValue: Array(repeating: false, count: destinationViewModel.destinations.count))
        _isShowDetailExit = State(initialValue: Array(repeating: false, count: destinationViewModel.exitGates.count))
    }
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List{
                    Section(header: Text("Tempat Populer").font(.headline).fontWeight(.bold).foregroundColor(.black)) {
                        ForEach(destinationViewModel.destinations.indices, id: \.self) {index in
                            let dest = destinationViewModel.destinations[index]
                            Button {
                                isShowExit[index].toggle()
                            } label: {
                                DestinationOnly(photoPath: dest.photoPath, destinationName: dest.destinationName, destinationExit: dest.destinationExit)
                                    .foregroundColor(.black)
                            }
                            .sheet(isPresented: $isShowExit[index], content: {
                                DestinationToExitOption(destination: dest.destinationName, badgeType: dest.destinationType, showModal: $isShowExit[index])
                            })

                        }

                    }
                    .listRowBackground(Color.Background.surface)

                    Section(header: Text("Pintu Keluar").font(.headline).fontWeight(.bold).foregroundColor(.black)) {
                        ForEach(destinationViewModel.exitGates.indices, id: \.self) {index in
                            let exit = destinationViewModel.exitGates[index]

                            Button{
                                isShowDetailExit[index].toggle()
                            } label:{
                                ExitOnly(name: exit.name, destination: exit.destination)
                                    .foregroundColor(.black)
                            }
                            .sheet(isPresented: $isShowDetailExit[index]) {
                                DetailExitGate(destination: exit.name, badgeType: exit.type, showModal: $isShowDetailExit[index], destinationViewModel: destinationViewModel)
                            }
                        }
                    }
                    .listRowBackground(Color.Background.surface)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .scrollContentBackground(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listStyle(InsetGroupedListStyle()) // Remove the inset around the list
                .background(Color.gray.opacity(0))
                
            }
            .searchable(text: $searchText, prompt: "Mau kemana hari ini?")
            .onChange(of: searchText) { newValue in
                destinationViewModel.updateFilteredDestinations(with: newValue)
            }
        }
        
        
    }
}

struct ChooseDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDestinationView(destinationViewModel: DestinationViewModel())
    }
}

