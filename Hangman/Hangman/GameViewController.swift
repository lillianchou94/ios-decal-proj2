//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var correctButton: UIButton!
    @IBOutlet var incorrectButton: UIButton!
    @IBOutlet var hangPersonView: UIImageView!
    @IBOutlet var guessLabel: UILabel!
    @IBOutlet var incorrectGuessLabel: UILabel!
    var phrase: [Character] = []
    var guessedLetter: [Character] = []
    var correctlyGuessedLetter: [Character] = []
    var hangpersonState:Int = 1
    var lettersLeft:Int = 0
    var gameState:String = "in progress"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let temp:String = hangmanPhrases.getRandomPhrase()
        for letter in temp.characters{
            phrase.append(letter)
        }
        loadInterface()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //update guessed letters
    func updateGuess(s: Character){
        for i in 0...(phrase.count - 1){
            if s == phrase[i]{
                guessedLetter[i] = s
                correctlyGuessedLetter[i] = s
                lettersLeft--
                print(lettersLeft)
            }
        }
        var temp = ""
        for letter in correctlyGuessedLetter{
            temp.append(letter)
        }
        guessLabel.text = temp
    }
    
    //update wrongly guessed letters
    func updateWrongGuess(s:Character){
        var temp = incorrectGuessLabel.text!
        temp.append(s)
        temp += " "
        incorrectGuessLabel.text = temp
    }
    
    //update textview
    func didTapCorrect() {
        if gameState == "in progress"{
            //dummy guess
            for letter in phrase{
                if !(guessedLetter.contains(letter)){
                    print("guessed \(letter)")
                    updateGuess(letter)
                    guessedLetter.append(letter)
                    break
                }
            }
            
        }
        if lettersLeft == 0{
            gameState = "win"
        }
        checkGameState()
    }
    
    //change hangperson state
    func didTapIncorrect(){
        if gameState == "in progress"{
            if hangpersonState < 7{
                hangpersonState++
                let dummyWrongGuess = makeWrongGuess()
                print("guessed this wrong: \(dummyWrongGuess)")
                updateWrongGuess(dummyWrongGuess)
                guessedLetter.append(dummyWrongGuess)
            } else{
                gameState = "lose"
            }
        }
        switch hangpersonState{
        case 1:
            hangPersonView.image = UIImage(named: "hangman1.gif")
        case 2:
            hangPersonView.image = UIImage(named: "hangman2.gif")
        case 3:
            hangPersonView.image = UIImage(named: "hangman3.gif")
        case 4:
            hangPersonView.image = UIImage(named: "hangman4.gif")
        case 5:
            hangPersonView.image = UIImage(named: "hangman5.gif")
        case 6:
            hangPersonView.image = UIImage(named: "hangman6.gif")
        case 7:
            hangPersonView.image = UIImage(named: "hangman7.gif")
        default:
            break
        }
        checkGameState()
    }
    
    //dummy function to make a wrong guess
    func makeWrongGuess() -> Character{
        for letter in "QWERTYUIOPASDFGHJKLZXCVBNM".characters{
            if !phrase.contains(letter) && !guessedLetter.contains(letter){
                return letter
            }
        }
        return " "
    }
    
    func checkGameState(){
        switch gameState{
            case "win":
                hangPersonView.image = UIImage(named: "hangman WIN.gif")
            case "lose":
                hangPersonView.image = UIImage(named: "hangman LOSE.gif")
            default:
                break;
        }
        
    }
    
    func makeGuessLabel() -> String{
        var rtn: String = ""
        for letter in phrase{
            if letter != " "{
                rtn += "-"
                lettersLeft++
                print(letter)
                print(lettersLeft)
            } else{
                rtn += " "
            }
        }
        return rtn
    }
    
    func loadInterface() {
        lettersLeft = 0
        let myphrase = makeGuessLabel();
        guessLabel.text = myphrase
        
        for letter in myphrase.characters{
            guessedLetter.append(letter)
            correctlyGuessedLetter.append(letter)
        }
        
        incorrectGuessLabel.text = "Incorrect guesses: ";
        hangPersonView.image = UIImage(named: "hangman1.gif")
        
        correctButton.addTarget(self, action: "didTapCorrect", forControlEvents: .TouchUpInside)
        incorrectButton.addTarget(self, action: "didTapIncorrect", forControlEvents: .TouchUpInside)
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
