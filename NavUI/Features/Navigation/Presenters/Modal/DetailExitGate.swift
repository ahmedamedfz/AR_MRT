//
//  DetailExitGate.swift
//  NavUI
//
//  Created by Patricia Ho on 23/07/23.
//

import SwiftUI

struct DetailExitGate: View {
    var destination: String
    var badgeType: String
    @Binding var showModal: Bool
    
    let imageView = [
        "exitAAround", "exitASignage", "exitASignageOutside", "exitASignageOutside1"
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
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(imageView, id: \.self) { imageName in
                                    ClippedImage(imageName, width: 100, height: 100)
                                        .foregroundStyle(.white)
                                        .font(.largeTitle)
                                }

                            }
                        }
                        
                    }
                    .padding(16)
                    
                    // Lanjutin disini
                    
                    
                    
                    
                }
            }
        }
    }
}

struct DetailExitGate_Previews: PreviewProvider {
    static var previews: some View {
        DetailExitGate(destination: ("FX Sudirman"), badgeType: ("Exit Gate"), showModal: .constant(true))
    }
}
