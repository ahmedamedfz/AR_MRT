//
//  DestinationToExitOption.swift
//  NavUI
//
//  Created by Patricia Ho on 23/07/23.
//

import SwiftUI

struct DestinationToExitOption: View {
    @Binding var destination: String
    @Binding var badgeType: String
    @Binding var showModal: Bool
    @State private var showAlert = false
    
    let exitWayList = [
        [ "A", "600", "FX Sudirman"],
        [ "B", "1000", "Pintu 6 GBK"],
    ]
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack (alignment: .leading, spacing: 16){
                    VStack (alignment: .leading, spacing: 12) {
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
                            // Set the state variable to true to show the alert
                            showAlert = true
                        }
                        // Use alert to show the confirmation dialog
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Perhatian"),
                                message: Text("Navigasi ini hanya bisa digunakan saat Anda di stasiun"),
                                primaryButton: .default(Text("Continue")) {
                                    // Add navigation logic here
                                    // For example, you can use NavigationLink to navigate to another page
                                    // NavigationLink(destination: YourDestinationView()) { EmptyView() }
                                },
                                secondaryButton: .cancel(Text("Cancel")) {
                                    showAlert = false // Set showAlert back to false when user cancels the alert
                                }
                            )
                        }
                    }
                    .padding(.top, -30)
                    .background(Color.Background.background)
                    .scrollContentBackground(.hidden)
                    
                    
                    
                }
            }
                    }
    }
}

struct DestinationToExitOption_Previews: PreviewProvider {
    static var previews: some View {
        DestinationToExitOption(destination: .constant("FX Sudirman"), badgeType: .constant("Landmark"), showModal: .constant(true))
    }
}
