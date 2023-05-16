//
//  Country.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 05/04/23.
//
//  Class designed to store the information of each country

import Foundation
import SwiftUI

struct Country: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var possibleAnswers: [String]
    private var flagName: String
    var flag: Image{ Image(flagName) }
    private var outlineName: String
    var outline: Image{ Image(outlineName) }
    var capital: String
    var continent: String
    var landBorders: [String]
    var trivia: [String]
    var population: String
    var area: String
    var currency: String
    
}
