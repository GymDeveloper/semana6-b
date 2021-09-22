//
//  Wanteds.swift
//  semana6-b
//
//  Created by Linder Hassinger on 22/09/21.
//

import Foundation

// Esta sera nuestra clase padre
class Animes: Codable {
    let request_hash: String
    let results: [Results]
}

// Items un child de Wanteds
class Results: Codable {
    let image_url: String
    let title: String
    let synopsis: String
}
