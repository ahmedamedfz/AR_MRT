//
//  ChooseStationView.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 22/07/23.
//

import SwiftUI

struct ChooseStationView: View {
    @Binding var station: String?
    @State private var isShowList = false
    
    var body: some View {
        ZStack(alignment: .top){
            VStack{
                Button{
                    isShowList.toggle()
                } label: {
                    HStack{
                        Image("TrainIcon")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Spacer()
                        Text(station!)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1)
                    }
                }
                .padding([.top, .leading, .trailing], 20)
            }
            .sheet(isPresented: $isShowList) {
                StationOption(isShowList: $isShowList, station: $station)
            }
            
        }
    }
}

struct ChooseStationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseStationView(station: .constant("Haii"))
    }
}
