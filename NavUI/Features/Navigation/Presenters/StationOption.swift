//
//  StationOption.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 22/07/23.
//

import SwiftUI

struct StationOption: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var station: String?
    @Binding var isShowList: Bool
    
    init(isShowList: Binding<Bool>, station: Binding<String?>){
        _isShowList = isShowList
        _station = station
    }
    
    let stations = ["Stasiun Lebak Bulus Grab",
                    "Stasiun Fatmawati Indomaret",
                    "Stasiun Cipete Raya",
                    "Stasiun Haji Nawi",
                    "Stasiun Blok A",
                    "Stasiun Blok M BCA",
                    "Stasiun ASEAN",
                    "Stasiun Senayan",
                    "Stasiun Istora Mandiri",
                    "Stasiun Bendungan Hilir",
                    "Stasiun Setiabudi Astra",
                    "Stasiun Dukuh Atas BNI",
                    "Stasiun Bundaran HI",]

    var body: some View {
//        List (stations
        VStack {
            List (stations, id: \.self, selection: $station){ name in
                Text(name)
            }
        }
//        .onTapGesture {
//                        isShowList.toggle()
//            self.presentationMode.wrappedValue.dismiss()
//
//        }
        .presentationDetents([.medium])
    }
}

//struct StationOption_Previews: PreviewProvider {
//    static var previews: some View {
//        StationOption()
//    }
//}
