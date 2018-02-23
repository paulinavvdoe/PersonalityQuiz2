//
//  QuestionViewController.swift
//  PersonalityQuiz2
//
//  Created by Paulina Van der Doe on 23/02/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    // Make outlets for object in storyboard.
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    // Initialize question index and make an empty array for given answers.
    
    var questions: [Question] = [
        Question(text: "What is your favorite alcoholic drink?", type: .single, answers: [Answer(text: "Red wine", type: .gorgonzola), Answer(text: "White wine", type: .brie), Answer(text: "Beer", type: .gouda), Answer(text: "I don't drink alcohol", type: .goat)]),
        
        Question(text: "Which dish do you prefer?", type: .single, answers: [Answer(text: "Mac 'n Cheese", type: .gouda), Answer(text: "Salad", type: .goat), Answer(text: "Sandwich", type: .brie), Answer(text: "Anything with mold on it", type: .gorgonzola)]),
        
        Question(text: "Which activities do you enjoy?", type: . multiple, answers: [Answer(text: "Hiking", type: .goat), Answer(text: "Watching television", type: .gouda), Answer(text: "Going to the museum", type: .brie), Answer(text: "Sports", type: .gorgonzola)]),
        
        Question(text: "How many close friends do you have?", type: .single, answers: [Answer(text: "1-2", type: .goat), Answer(text: "3-4", type: .gorgonzola), Answer(text: "5-6", type: .brie), Answer(text: "7+", type: .gouda)]),
        
        Question(text: "What did you study?", type: . single, answers: [Answer(text: "Social Sciences", type: .brie), Answer(text: "Only finished high school", type: .gouda), Answer(text: "Liberal arts", type: .gorgonzola), Answer(text: "Physics", type: .goat)]),
        
        Question(text: "How much do you enjoy cheese?", type: .ranged, answers: [Answer(text: "Not so much", type: .gouda), Answer(text: "I like to eat it sometimes", type: .brie), Answer(text: "I eat it quite a lot", type: .goat), Answer(text: "I LOVE IT!!!", type: .gorgonzola)])
    ]
    // Different questions and type and answers belonging to the quiston.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ResultsSegue" {
        // Check is segue is results segue.
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
            // If so, send answers to result screen.
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
    // Function to store data from single answer questions.
        
        let currentAnswers = questions[questionIndex].answers
        // Import answerdata into current answer.
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        // Check which button is pressed.
        
        nextQuestion()
        // Call function next question.
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
    // Function to store data from multiple answer questions.
        
        let currentAnswers = questions[questionIndex].answers
        // Store data into constant.
        
        if multiSwitch1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn{
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn{
            answersChosen.append(currentAnswers[3])
        }
        // Check which switches were on.
        
        nextQuestion()
        // Call function nextQuestion to go to next question.
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: Any) {
    // Function to store data from ranged answer question.
        
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        // Load data into constant and convert to integer value.
        
        answersChosen.append(currentAnswers[index])
        // Store data from question.
        
        nextQuestion()
        // Call function nextQuestion to go to next question.
    }
    
    func nextQuestion() {
    // Function to load new question if any.
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        // Check if there are any questions left, if so go to next.
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        // If no question left go to result screen.
        }
    }
    
    func updateUI(){
    // Update screen data everytime a question is answered.
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        // Hide all views
        
        navigationItem.title = "Question #\(questionIndex+1)"
        // Show next question.
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        // Update variables.
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        // Update tilte, labels and progressview.
        
        switch currentQuestion.type{
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        // Check which view to display.
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    // Show UI for single answer questions.

    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    // Show UI for multiple answer questions.
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    // Sow UI for slider questions.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
