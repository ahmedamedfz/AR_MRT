//
//  ExitOnly.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import SwiftUI

struct ExitOnly: View {
    var name: String
    var destination: [String]
    
    
    var body: some View {
        HStack{
            Text("\(String(name.last!))")
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 48, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                    
                )
            VStack (alignment: .leading){
                Text(name)
                    .font(.subheadline)
                    .padding(.bottom, 0.1)
                Text("\(destination.joined(separator: ", "))")
                    .font(.caption)
            }
        }
    }
}

struct ExitOnly_Previews: PreviewProvider {
    static var previews: some View {
        ExitOnly(name: "Pintu Keluar A", destination: ["Stadion GBK", "Jl. Pintu Satu Senayan"])
    }
}
