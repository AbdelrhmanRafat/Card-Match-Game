//
//  ModelCard.swift
//  CardMatch
//
//  Created by Macbook on 10/12/2020.
//

import Foundation
class CardModel {
    
    func GetCards() -> [Card] {
        var arrayCards = [Card]()
        for ind in 1...13 {
            let CardOne = Card()
            let CardTwo = Card()
            CardOne.ImageName = "card\(ind)"
            CardTwo.ImageName = "card\(ind)"
            arrayCards += [CardOne,CardTwo]
        }
        arrayCards.shuffle()
        return arrayCards
    }
}
