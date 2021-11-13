//
//  ViewController.swift
//  CardMatch
//
//  Created by Macbook on 10/12/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var arrayCards = CardModel().GetCards()
    @IBOutlet var TimeLabel : UILabel!
    @IBOutlet var collectionView : UICollectionView!
    var firstCardFlippedIndex : IndexPath?
    var soundPlayer = soundManager()
    var millisecond : Int = 20 * 1000
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        soundPlayer.playSound(effect: .shuffle)
    }
    @objc func timerFired(){
        millisecond -= 1
        let seconds:Double = Double(millisecond) / 1000.0
        TimeLabel.text = String(format: "Time Remaining: %.2f", seconds)
        if millisecond == 0 {
            TimeLabel.textColor = UIColor.red
            timer?.invalidate()
            checkEndGame()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayCards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let cell = collectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let CardCell = cell as? CardCollectionViewCell
        CardCell?.configCell(card: arrayCards[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        if cell.card?.isFlipped == false && cell.card?.isMatch == false && millisecond > 0{
            if firstCardFlippedIndex == nil {
                cell.flipUp(speed: 0.5)
                soundPlayer.playSound(effect: .flip)
                firstCardFlippedIndex = indexPath
            }
            else {
                cell.flipUp(speed: 0.5)
                checkForMatch(indexPath)
            }}
    }
    func checkForMatch(_ secondCardFlippedIndex : IndexPath) {
        let cardOne = arrayCards[firstCardFlippedIndex!.row]
        let cardTwo = arrayCards[secondCardFlippedIndex.row]
        let cardOneCell = collectionView.cellForItem(at: firstCardFlippedIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondCardFlippedIndex) as?
          CardCollectionViewCell
        if cardOne.ImageName == cardTwo.ImageName {
            cardOne.isMatch = true
            cardTwo.isMatch = true
            cardOneCell?.remove()
            cardTwoCell?.remove()
            soundPlayer.playSound(effect: .math)
            checkEndGame()
        }
        else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.flipDown(speed: 0.3, delayTime: 0.5)
            cardTwoCell?.flipDown(speed: 0.3, delayTime: 0.5)
            soundPlayer.playSound(effect: .nomatch)
        }
        firstCardFlippedIndex = nil
    }
    func checkEndGame(){
        var hasWon = true
        for card in arrayCards {
            if card.isMatch == false {
                hasWon = false
                break
            }}
        if hasWon{
            showAlert(title: "Congratulations!", message: "You have won the game")
        }
        else{
            if millisecond <= 0 {
            showAlert(title: "Time's up", message: "sorry, better luck next time!")
                
            }}
    }
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
            self.ResetGame()
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func ResetGame() {
        arrayCards = CardModel().GetCards()
        millisecond = 20 * 1000
        collectionView.reloadData()
        TimeLabel.textColor = UIColor.black
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
}

