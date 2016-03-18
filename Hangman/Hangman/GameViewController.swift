import UIKit

class GameViewController: UIViewController {
    @IBOutlet var hangPersonView: UIImageView!
    @IBOutlet var guessLabel: UILabel!
    @IBOutlet var incorrectGuessLabel: UILabel!
    
    var phraseString: String = ""
    var phrase: [Character] = []
    var guessedLetter: [Character] = []
    var correctlyGuessedLetter: [Character] = []
    var hangpersonState:Int = 1
    var lettersLeft:Int = 0
    var gameState:String = "in progress"
    var buttonArray: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phraseString = hangmanPhrases.getRandomPhrase()
        print(phraseString)
        for letter in phraseString.characters{
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
    

    @IBAction func guessButtonPressed(sender: UIButton) {
        if gameState == "in progress"{
            var letter: Character!
            for c in sender.titleLabel!.text!.characters{
                letter = c
            }
            if phrase.contains(letter){
                didTapCorrect(letter)
            } else{
                didTapIncorrect(letter)
            }
            sender.hidden = true
            buttonArray.append(sender)
        }
    }
    
    @IBAction func didTapReset(){
        hangPersonView.image = UIImage(named: "hangman1.gif")
        hangpersonState = 1
        guessLabel.text = makeGuessLabel()
        gameState = "in progress"
        setUpGuessedArray(makeGuessLabel())
        incorrectGuessLabel.text = "Incorrect guesses: "
        for button in buttonArray{
            button.hidden = false
        }
    }
    
    //update textview
    func didTapCorrect(letter: Character) {
        if gameState == "in progress"{
            updateGuess(letter)
            guessedLetter.append(letter)
            
        }
        if lettersLeft == 0{
            gameState = "win"
        }
        checkGameState()
    }
    
    //change hangperson state
    func didTapIncorrect(letter: Character){
        if gameState == "in progress"{
            if hangpersonState < 7{
                hangpersonState++
                updateWrongGuess(letter)
                guessedLetter.append(letter)
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
                displayResult("You WON!")
                break;
            case "lose":
                displayResult("You LOST LOL")
                break;
            default:
                break;
        }
    }
    
    func displayResult(msg: String){
        let alertController = UIAlertController(title: msg, message: nil,preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func makeGuessLabel() -> String{
        lettersLeft = 0
        var rtn: String = ""
        for letter in phrase{
            if letter != " "{
                rtn += "-"
                lettersLeft++
            } else{
                rtn += " "
            }
        }
        return rtn
    }
    
    func setUpGuessedArray(myphrase: String){
        guessedLetter = []
        correctlyGuessedLetter = []
        for letter in myphrase.characters{
            guessedLetter.append(letter)
            correctlyGuessedLetter.append(letter)
        }
    }
    
    func loadInterface() {
        lettersLeft = 0
        let myphrase = makeGuessLabel();
        guessLabel.text = myphrase
        
        setUpGuessedArray(myphrase)
        incorrectGuessLabel.text = "Incorrect guesses: "
        hangPersonView.image = UIImage(named: "hangman1.gif")
        
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
