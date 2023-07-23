//
//  ChooseDestinationView.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import SwiftUI

struct ChooseDestinationView: View {
    @ObservedObject var destinationViewModel: DestinationViewModel
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Tempat Populer")
                    .font(.headline)
                VStack(alignment: .leading){
                    ForEach(destinationViewModel.destinations, id: \.id) {dest in
                        HStack{
                            Image(dest.photoPath)
                                .resizable()
                                .frame(width: 48, height: 48)
                                .cornerRadius(10)
                            VStack (alignment: .leading){
                                Text(dest.destinationName)
                                    .font(.subheadline)
                                    .padding(.bottom, 0.1)

                                Text("Nearest Exit: **\(dest.destinationExit)**")
                                    .font(.caption)
                            }
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color.Background.surface)
                    .frame(width: .infinity, height: .infinity))
                
                Text("Pintu Keluar")
                    .font(.headline)
                    .padding(.top, 20)
                VStack(alignment: .leading){
                    ForEach(destinationViewModel.exitGates, id: \.id) {exit in
                        HStack{
                            Text("\(String(exit.name.last!))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(width: 48, height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.white)
                                    
                                )
                            VStack (alignment: .leading){
                                Text(exit.name)
                                    .font(.subheadline)
                                    .padding(.bottom, 0.1)
                                Text("\(exit.destination.joined(separator: ", "))")
                                    .font(.caption)
                            }
                        }
                    }
                }
//                .frame(width: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color.Background.surface)
                    .frame(width: .infinity, height: .infinity))

                


                Spacer()
            }
            .ignoresSafeArea()
            .frame(width: .infinity)

            
        }
    }
}

struct ChooseDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDestinationView(destinationViewModel: DestinationViewModel())
    }
}

