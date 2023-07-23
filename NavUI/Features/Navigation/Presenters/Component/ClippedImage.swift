//
//  ClippedImage.swift
//  NavUI
//
//  Created by Patricia Ho on 23/07/23.
//

import SwiftUI

struct ClippedImage: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat

    init(_ imageName: String, width: CGFloat, height: CGFloat) {
        self.imageName = imageName
        self.width = width
        self.height = height
    }
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
        }
        .cornerRadius(10) // Necessary for working
        .frame(width: width, height: height)
    }
}

struct ClippedImage_Previews: PreviewProvider {
    static var previews: some View {
        ClippedImage("route-ciremai", width: 300, height: 300)
    }
}
