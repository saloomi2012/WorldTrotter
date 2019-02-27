//
//  MathViewController.swift
//  WorldTrotter
//
//  Created by Suliman Alsaid on 2/21/19.
//  Copyright © 2019 Suliman Alsaid & Morgan Forester. All rights reserved.
//

import UIKit

class MathViewController: UIViewController {
    
    @IBOutlet var currentQuestion: UILabel!
    
    @IBOutlet var operand1: UILabel!
    @IBOutlet var op: UILabel!
    @IBOutlet var operand2: UILabel!
    @IBOutlet var result: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var medal: UIImageView!
    @IBOutlet var answer: UITextField!
    
    var questionCount = 0
    var correctCount = 0
    var q: Question!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionCount = 1
        q = generateQuestion()
        updateQuestion(q)
        correctCount = 0
        score.text = "Score: \(correctCount)/\(questionCount)"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        if let ans = Int(answer.text!){
            if(ans == calculate(q)) {
                correctCount += 1
                result.text = "Result: Correct!"
            } else {
                result.text = "Result: Incorrect! The answer was \(calculate(q))."
            }
            score.text = "Score: \(correctCount)/\(questionCount)"
            
            if(questionCount == 10) {
                switch(correctCount){
                case 10:
                    medal.image = UIImage(named: "PlatinumMedal")
                case 9:
                    medal.image = UIImage(named: "GoldMedal")
                default:
                    medal.image = UIImage(named: "TryMedal")
                }
                
            }
            
            
        }
        
        
        
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        if(questionCount < 10) {
            questionCount += 1
            q = generateQuestion()
            updateQuestion(q)
            score.text = "Score: \(correctCount)/\(questionCount)"
            result.text = "Result:"
            currentQuestion.text = "Question \(questionCount)/10"
        }
    }
    @IBAction func newQuiz(_ sender: Any) {
        questionCount = 1
        currentQuestion.text = "Question \(questionCount)/10"
        q = generateQuestion()
        updateQuestion(q)
        correctCount = 0
        score.text = "Score: \(correctCount)/\(questionCount)"
        result.text = "Result:"
        medal.image = nil
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        answer.resignFirstResponder()
    }
    
    struct Question {
        var num1 : Int
        var num2 : Int
        var op : String
    }
    
    func generateQuestion() -> Question {
        let num1 = Int.random(in: -10...20)
        var num2 = Int.random(in: -10...20) 
        while(num2 == 0) {
            num2 = Int.random(in: -10...20)
        }
        var op: String!
        switch(Int.random(in: 1...4)) {
        case 1:
            op = "+"
            break
        case 2:
            op = "-"
            break
        case 3:
            op = "*"
            break
        case 4:
            op = "/"
            break
        default:
            break
        }
        
        return Question(num1: num1, num2: num2, op: op)
        
    }
    
    func updateQuestion(_ q: Question) {
        operand1.text = "\(q.num1)"
        op.text = q.op
        operand2.text = "\(q.num2)"
        
        currentQuestion.text = "Question \(questionCount)/10"
    }
    
    func calculate(_ question: Question) -> Int {
        switch(question.op) {
        case "+":
            return question.num1 + question.num2
        case "-":
            return question.num1 - question.num2
        case "*":
            return question.num1 * question.num2
        case "/":
            return question.num1 / question.num2
        default:
            return -1111
        }
    }
    
    
    
    
//    func add(_ a: Int, _ b:Int) -> Int {
//        return a+b
//    }
//
//    func sub(_ a: Int, _ b:Int) -> Int {
//        return a-b
//    }
//
//    func mul(_ a: Int, _ b:Int) -> Int {
//        return a*b
//    }
//
//    func div(_ a: Int, _ b:Int) -> Int {
//        if b != 0 {
//            return a/b
//        } else {
//            return 42
//        }
//    }
//
//    typealias binOp = (Int, Int) -> Int
//
    // This keeps spitting out an error we cannot figure out
//    let ops: [String: binOp] = ["+":add, "-":sub, "*":mul, "/":div]
//
//
//    func doMath(_ a: Int, _ b: Int, _ op: String) -> Int {
//        let opFunc = ops[op]
//        return opFunc!(a, b)
//    }
    
    
    
}
