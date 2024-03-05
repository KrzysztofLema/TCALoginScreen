//
//  Credentials.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 05/03/2024.
//

import Foundation
import ComposableArchitecture

struct Credentials: Equatable, Codable {
    var login: String = ""
    var password: String = ""
}
