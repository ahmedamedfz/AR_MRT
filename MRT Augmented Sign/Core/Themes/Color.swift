//
//  Color.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 22/07/23.
//

import SwiftUI

extension Color {
    struct Blue {
        static let s10 = Color("blue-10")
        static let s20 = Color("blue-20")
        static let s25 = Color("blue-25")
        static let s30 = Color("blue-30")
        static let s35 = Color("blue-35")
        static let s40 = Color("blue-40")
        static let s50 = Color("blue-50")
        static let s60 = Color("blue-60")
        static let s70 = Color("blue-70")
        static let s80 = Color("blue-80")
        static let s90 = Color("blue-90")
        static let s95 = Color("blue-95")
        static let s98 = Color("blue-98")
        static let s99 = Color("blue-99")
        
        private init() {}
    }
    
    struct Primary {
        static let primary = Color("blue-35")
        static let onPrimary = Color("blue-100")
        static let primaryContainer = Color("blue-95")
        static let onPrimaryContainer = Color("blue-10")
    }
    
    struct Secondary {
        static let secondary = Color("green-60")
        static let onSecondary = Color("green-100")
        static let secondaryContainer = Color("green-98")
        static let onSecondaryContainer = Color("green-20")
    }
    
    struct Danger {
        static let danger = Color("red-40")
        static let onDanger = Color("red-100")
        static let dangerContainer = Color("red-95")
        static let onDangerContainer = Color("red-10")
    }
    
    struct Background {
        static let background = Color("gray-100")
        static let onBackground = Color("gray-0")
        static let surface = Color("gray-95")
        static let onSurface = Color("gray-0")
    }
    
    struct Label {
        static let aa = Color("gray-20")
        static let aaa = Color("gray-0")
        static let disabled = Color("gray-70")
    }
    
    struct Border {
        static let border1 = Color("gray-80")
        static let border2 = Color("gray-85")
        static let border3 = Color("gray-88")
        static let border4 = Color("gray-91")
        static let border5 = Color("gray-95")
    }
}
