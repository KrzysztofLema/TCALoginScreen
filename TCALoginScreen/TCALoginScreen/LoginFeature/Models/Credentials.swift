//
//  Credentials.swift
//  TCALoginScreen
//
//  Created by Krzysztof Lema on 05/03/2024.
//

import ComposableArchitecture
import Foundation

struct Credentials: Equatable, Codable {
    var login: String = ""
    var password: String = ""
}
