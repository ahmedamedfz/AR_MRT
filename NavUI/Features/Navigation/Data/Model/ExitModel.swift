//
//  ExitModel.swift
//  NavUI
//
//  Created by Jihan Alfiyyah Munajat on 23/07/23.
//

import Foundation

struct Exit: Identifiable {
    var id: UUID
    var name: String
    var type: String
//    var destination: [Destination]
    var destination: [String]
}
