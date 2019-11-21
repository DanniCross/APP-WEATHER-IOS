//
//  Model.swift
//  ForeCast
//
//  Created by Prog on 10/1/19.
//  Copyright © 2019 Prog. All rights reserved.
//

import Foundation

struct Main : Decodable {
    let temp : Float
    let tempMin : Float
    let tempMax : Float
}

struct Weather: Decodable {
    let icon : String
}

struct Root : Decodable {
    let main : Main
    let weather: [Weather]
}
