//
//  BlankPage.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 22/07/23.
//

import SwiftUI

struct BlankPage: View {
    var body: some View {
        VStack{
            Image("BlankImage")
                .resizable()
                .frame(width: 96, height: 96)
                .padding(.bottom, 10)
            Text("Belum ada stasiun yang dipilih")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 1)
            Text("Pilih stasiun untuk menampilkan tempat populer, jalan terdekat, dan pintu keluar")
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BlankPage_Previews: PreviewProvider {
    static var previews: some View {
        BlankPage()
    }
}
