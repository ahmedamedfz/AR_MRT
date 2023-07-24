//
//  NestView.swift
//  MRT Augmented Sign
//
//  Created by Ahmad Fariz on 22/07/23.
//

import SwiftUI

struct NestView: View {
    @ObservedObject var viewModel = PredictionViewModel.shared
    @State private var isShowingARView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Choose Your Gate")
                Spacer()
                List(MapDestination.allCases){mapDestination in
                    NavigationLink(mapDestination.rawValue, value: mapDestination)
                }.navigationDestination(for: MapDestination.self) { mapDestination in
                    ARViewControllerNest()
                        .onAppear{
                            let mapPointer = MapPointer()
                            viewModel.selectedGate = mapDestination
                            viewModel.signDictionary = mapPointer.pathToDestination(destination:mapDestination)
                            print(viewModel.signDictionary!.values)
                        }
                }
            }
        }
    }
}

struct NestView_Previews: PreviewProvider {
    static var previews: some View {
        NestView()
    }
}
