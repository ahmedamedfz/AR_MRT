//
//  ContentView.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 22/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var station: String? = "Pilih Stasiun"

    var body: some View {
        VStack{
            Text("Peta Navigasi")
                .font(.title3)
                .bold()
                Divider()
            ChooseStationView(station: $station)
//            Spacer()
            
            if station == "Pilih Stasiun" {
                BlankPage()
            } else {
                ChooseDestinationView(destinationViewModel: DestinationViewModel())
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
