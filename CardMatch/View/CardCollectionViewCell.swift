//
//  CardCollectionViewCell.swift
//  CardMatch
//
//  Created by Macbook on 10/12/2020.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var FronImageView : UIImageView!
    @IBOutlet var BackImageView : UIImageView!
    var card : Card?
    func configCell(card:Card) {
        self.card = card
        FronImageView.image = UIImage(named: card.ImageName)
        if card.isMatch == true {
            FronImageView.alpha = 0
            BackImageView.alpha = 0
            return
        }
        else {
            FronImageView.alpha = 1
            BackImageView.alpha = 1
        }
        if card.isFlipped {
            flipUp(speed: 0)
        }
        else {
            flipDown(speed: 0,delayTime: 0)
        }
    }
    func flipUp(speed: TimeInterval) {
        UIView.transition(from: BackImageView, to: FronImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        card?.isFlipped = true
    }
    func flipDown(speed: TimeInterval,delayTime: TimeInterval){
        card?.isFlipped = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
            
            // Flip down animation
            UIView.transition(from: self.FronImageView, to: self.BackImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
            
        }
       
    }
    func remove() {
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.FronImageView.alpha = 0
            self.BackImageView.alpha = 0
        }, completion: nil)
    }
    
}
