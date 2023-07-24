//
//  DestinationToExitOption.swift
//  NavUI
//
//  Created by Patricia Ho on 23/07/23.
//

import SwiftUI

struct DestinationToExitOption: View {
    var destination: String
    var badgeType: String
    @Binding var showModal: Bool
    @ObservedObject private var predictionViewModel = PredictionViewModel.shared
    @State private var showAlert = false
    @State private var showAR = false
    
    let exitWayList = [
        [ "A", "600", "FX Sudirman"],
        [ "B", "1000", "Pintu 6 GBK"],
        [ "C", "600", "Bursa Efek Indonesia"],
        [ "D", "700", "Pacific Place"],
    ]
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 16){
                    HStack(alignment: .top) {
                        VStack (alignment: .leading, spacing: 8) {
                            Text("\(destination)")
                                .font(.title3)
                                .fontWeight(.bold)
                            Badge(badgeType: badgeType)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.showModal.toggle()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .padding(10)
                                .background(Color.Label.aa)
                                .foregroundColor(Color.Background.background)
                                .cornerRadius(100)
                        }
                        
                    }
                    
                    Text("Untuk menuju \(destination), berikut adalah exit terdekat yang bisa Anda ambil")
                        .font(.footnote)
                        .foregroundColor(Color.Label.aaa)
                }
                .padding(16)
                
                
                List(exitWayList, id: \.self) { section in
                    ChooseExitOptionView(
                        exitGate: section[0],
                        finalDestination: section[2],
                        distanceInMetres: Int(section[1])!
                    )
                    .listRowBackground(Color.Background.surface)
                    .listStyle(PlainListStyle())
                    .onTapGesture {
                        let destinationGate = section[0]
                        switch destinationGate{
                        case "A":
                            predictionViewModel.selectedGate = .ExitA
                        case "B":
                            predictionViewModel.selectedGate = .ExitB
                        case "C":
                            predictionViewModel.selectedGate = .ExitC
                        case "D":
                            predictionViewModel.selectedGate = .ExitD
                        default:
                            predictionViewModel.selectedGate = .ExitA
                        }
                        // Set the state variable to true to show the alert
                        showAlert = true
                    }
                    // Use alert to show the confirmation dialog
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Perhatian"),
                            message: Text("Navigasi ini hanya bisa digunakan saat Anda di stasiun"),
                            primaryButton: .default(Text("Continue")) {
                                showAR = true
                            }
                            ,
                            secondaryButton: .cancel(Text("Cancel")) {
                                showAlert = false // Set showAlert back to false when user cancels the alert
                            }
                        )
                    }
                }
                .padding(.top, -30)
                .background(Color.Background.background)
                .scrollContentBackground(.hidden)
                .navigationDestination(isPresented: $showAR){
                    ARViewControllerNest().onAppear{
                        let mapPointer = MapPointer()
                        predictionViewModel.signDictionary = mapPointer.pathToDestination(destination:predictionViewModel.selectedGate!)
                    }
                }
            }
        .presentationDetents(showAR ?   [.large] : [.medium] )

    }
}

struct DestinationToExitOption_Previews: PreviewProvider {
    static var previews: some View {
        DestinationToExitOption(destination: "FX Sudirman", badgeType: "Landmark", showModal: .constant(true))
    }
}
