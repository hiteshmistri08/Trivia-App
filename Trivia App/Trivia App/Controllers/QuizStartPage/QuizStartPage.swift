//
//  QuizStartPage.swift
//  Trivia App
//
//  Created by Hitesh on 01/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class QuizStartPage: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnNext: UIBarButtonItem!

    //Property
    private var quiz:Quiz!
    private let context = AppDelegate.shared.persistentContainer.viewContext

    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtName.becomeFirstResponder()
    }
    
    private func setupUI() {
        createQuizObject()
        txtName.delegate = self
    }
    func createQuizObject() {
        quiz = nil
        txtName.text = ""
        quiz = Quiz(context: self.context)
        quiz.question1 = "Who is the best cricketer in the world?"
        quiz.question1Options = "Sachin Tendulkar,Virat Kolli,Adam Gilchirst,Jacques Kallis"
        quiz.question2 = "What are the colors in the Indian national flag?"
        quiz.question2Options = "White,Yellow,Orange,Green"
        renderNextButton(false)
    }
    private func renderNextButton(_ isEnable:Bool) {
        btnNext.isEnabled = isEnable
    }
    private func isValidName(_ text:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.count)) != nil {
                return false
            } else {
                return true
            }
        }
        catch {
            print("ERROR")
        }
        return false
    }
    
    //MARK:- Navigation
        func navigateToQuizQuestionPage(_ quiz:Quiz, _ questionIndex:Int) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "QuizQuestionPage") as!     QuizQuestionPage
        vc.setQuizData(quiz, questionIndex)
       self.navigationController?.pushViewController(vc, animated: true)
    }

    
    //MARK:- IBAction
    @IBAction private func onBtnNextAction(_ sender: Any) {
        self.view.endEditing(true)
        quiz.name = txtName.text!.trimmingCharacters(in: .whitespaces)
        navigateToQuizQuestionPage(self.quiz, 1)
    }
    
    
}
//MARK:- UITextFieldDelegate
extension QuizStartPage:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        //Update the text
        let updatedText = textFieldText.replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespaces)
        // Check input text is valid or not
        let isEnable = isValidName(updatedText)
        // Minimum 4 charater required to enable the next button
        renderNextButton(updatedText.count > 3)
        return isEnable
    }
}

