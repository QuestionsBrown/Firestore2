//
//  DonutStruct.swift
//  FireStore2
//
//  Created by Concetta Turner on 11/5/18.
//  Copyright © 2018 Concetta Turner. All rights reserved.
//

import Foundation
import FirebaseStorage

struct myDonut: Decodable {
    let name: String
    let description: String
    let price: String
    let imageRef: String
}


