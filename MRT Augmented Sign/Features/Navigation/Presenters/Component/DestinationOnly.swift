//
//  DestinationOnly.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import SwiftUI

struct DestinationOnly: View {
    var photoPath: String
    var destinationName: String
    var destinationExit: String
    
    var body: some View {
        HStack{
            Image(photoPath)
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(10)
            VStack (alignment: .leading){
                Text(destinationName)
                    .font(.subheadline)
                    .padding(.bottom, 0.1)

                Text("Nearest Exit: **\(destinationExit)**")
                    .font(.caption)
            }
        }
    }
}

struct DestinationOnly_Previews: PreviewProvider {
    static var previews: some View {
        DestinationOnly(photoPath: "ImageGBK", destinationName: "Stadion Utama Gelora Bung Karno", destinationExit: "Exit B")
    }
}
