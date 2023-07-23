//
//  Badge.swift
//  NavUI
//
//  Created by Patricia Ho on 23/07/23.
//

import SwiftUI

struct Badge: View {
    var badgeType: String

    
    var body: some View {
        VStack {
            Text("\(badgeType)")
                .font(.caption2)
                .foregroundColor(Color.Background.background)
                .padding([.top, .bottom], 5)
                .padding([.leading, .trailing], 10)
                .background(badgeColor)
                .cornerRadius(10)
        }
    }
    
    private var badgeColor: Color {
        return badgeType == "Landmark" ? Color.Primary.onPrimaryContainer : Color.Danger.danger
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(badgeType: "Landmark")
    }
}

