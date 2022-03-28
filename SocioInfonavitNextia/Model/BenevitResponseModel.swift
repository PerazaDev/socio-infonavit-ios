//
//  BenevitResponseModel.swift
//  SocioInfonavitNextia
//
//  Created by Daniel Sanchez Peraza on 26/03/22.
//

import Foundation
struct BenevitResponseModel: Decodable{
    
    let locked: [Benevit]
    let unlocked : [Benevit]

    
}

struct Benevit : Decodable {
    let description : String
    let title : String
    let instructions : String
    let vector_full_path : String
    let wallet : Wallet
    let ally : Ally
}
struct Wallet : Decodable{
    let id :Int
}
struct Ally : Decodable{
    let mini_logo_full_path : String
}

