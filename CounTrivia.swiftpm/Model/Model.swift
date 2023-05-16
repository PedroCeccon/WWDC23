//
//  Model.swift
//  CounTrivia
//
//  Created by Pedro Ceccon on 05/04/23.
//
//  Holds all the information of the game and handles almost all of the controls necessary, also reads the JSON file and store it's information in an array of objects

import Foundation
import SwiftUI

enum GameStatus{
    case playing
    case win
    case timesUp
    case revealAnswer
}

enum Tip: CaseIterable{
    case outline
    case flag
    case capital
    case continent
    case landBorders
    case trivia
    
    func getName() -> String{
        if self != .landBorders{
            return "\(self)".prefix(1).capitalized + "\(self)".dropFirst()
        }
        else{
            return "Land Borders"
        }
    }
}

class Model: ObservableObject{
    var countries: [Country] = [Country]()
    var currentCountryID: Int = 0
    var remainingCountries: [Int] = [Int]()
    @Published var tipsUnlocked: [Tip: Bool] = [.outline: true,
                                                .flag: false,
                                                .capital: false,
                                                .continent: false,
                                                .landBorders: false,
                                                .trivia: false]
    @Published var points = 100
    var remainingTips = [Tip]()
    @Published var attemptMessage: String = ""
    @Published var rightAnswer = false
    @Published var time : Int = 40
    
    init() {
        countries = loadCountries()
        resetUsedCountries()
        currentCountryID = getCountry()
        for tip in Tip.allCases{
            if !getTipValue(tip){
                remainingTips.append(tip)
            }
        }
    }
    
    func loadCountries() -> [Country]{
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "CountryData", withExtension: "json")
        else{
            fatalError("Couldn't find CountryData.json")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("error")
        }
        
        do {
            return try JSONDecoder().decode([Country].self, from: data)
        } catch let error {
            print(error)
            return []
        }
    }
    
    func newGame(){
        attemptMessage = ""
        remainingTips = [Tip]()
        for tip in Tip.allCases{
            if tip != .outline{
                remainingTips.append(tip)
                tipsUnlocked[tip] = false
            }
        }
        points = 100
        time = 40
        removeUsedCountry()
        currentCountryID = getCountry()
    }

    func getCountry() -> Int{
        if remainingCountries.count == 0{
            resetUsedCountries()
        }
        if remainingCountries.count>0{
            let randomCountry = remainingCountries[Int.random(in: 0..<remainingCountries.count)]
            return randomCountry
        }
        else{
            fatalError("error")
        }
    }
    
    func resetUsedCountries(){
        for country in countries {
            remainingCountries.append(country.id)
        }
    }
    
    func removeUsedCountry(){
        if let index = remainingCountries.firstIndex(of: currentCountryID) {
            remainingCountries.remove(at: index)
        }
    }
    
    func unlockTip(_ tip: Tip){
        if let index = remainingTips.firstIndex(of: tip) {
            remainingTips.remove(at: index)
        }
        tipsUnlocked[tip] = true
    }
    
    func getTipValue(_ tip: Tip) -> Bool{
        if let tipValue = tipsUnlocked[tip]{
            return tipValue
        }
        else{
            return false
        }
    }
    
    func getTipString(_ tip: Tip) -> String{
        switch tip{
        case .capital:
            return countries[currentCountryID].capital
        case .continent:
            return countries[currentCountryID].continent
        default:
            return "error: tip string not available"
        }
    }
    
    func confirmAnswer(_ guess: String) -> GameStatus{
        if guess.isEmpty{
            attemptMessage = "Empty guess. Please write a country's name before trying again."
            return .playing
        }
        else{
            for answer in countries[currentCountryID].possibleAnswers{
                if guess.lowercased() == answer.lowercased(){
                    attemptMessage = ""
                    return .win
                }
            }
            attemptMessage = "Wrong answer. Please try again."
            return .playing
        }
    }
    
    func countTime(){
        time -= 1
    }
    
    func getTimeFormat() -> String{
        let k : Int = 60
        if time%k > 9{
            return "0\(time/k):\(time%k)"
        }
        else{
            return "0\(time/k):0\(time%k)"
        }
    }
}



