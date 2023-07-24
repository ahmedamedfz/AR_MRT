//
//  ChooseExitOptionView.swift
//  NavUI
//
//  Created by Patricia Ho on 23/07/23.
//

import SwiftUI

struct ChooseExitOptionView: View {
    var exitGate: String
    var finalDestination: String
    var distanceInMetres: Int
    
    var body: some View {
        VStack {
            HStack (spacing: 12) {
                ZStack {
                    Text("\(exitGate)")
                        .foregroundColor(Color.Primary.primary)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .frame(width: 48, height: 48)
                .background(Color.Background.background)
                .cornerRadius(10)
                
                VStack (alignment: .leading, spacing: 4) {
                    Text("Pintu Keluar \(exitGate)")
                        .font(.body)
                    Text("\(distanceInMetres) meter menuju \(finalDestination)")
                        .font(.caption)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
//            .frame(width: .infinity)
            .padding([.top, .bottom], 10)
        }
    }
}

struct ChooseExitView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseExitOptionView(exitGate: "A", finalDestination: "FX Sudirman", distanceInMetres: 600)
    }
}
