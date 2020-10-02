//
//  QuizSummary.swift
//  Trivia App
//
//  Created by Hitesh on 01/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class QuizSummary: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak private var lblSummary:UILabel!
    
    //Property
    private unowned var quiz:Quiz!

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        //Set summary text
        let summary = "Hello \(quiz.name ?? ""): \n\nHere are the answers selected:\n\n\(quiz.question1 ?? "")\n\nAnswer: \(quiz.questionAnswer1 ?? "")\n\n\(quiz.question2 ?? "")\n\nAnswers: \(quiz.questionAnswer2 ?? "")"
        lblSummary.text = summary
    }
    func setQuizData(_ quiz:Quiz) {
        self.quiz = quiz
    }
    //Clean QuizStartPage controller
    private func cleanQuizStartPage() {
        quiz = nil
        (self.navigationController?.viewControllers[0] as? QuizStartPage)?.createQuizObject()
    }
    
    //MARK:- Navigation
    private func navigateToQuizStartPage() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    private func navigateToQuizHistoryPage() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "QuizHistory") as! QuizHistory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- IBAction
    @IBAction private func onBtnFinish(_ sender: Any) {
        cleanQuizStartPage()
        navigateToQuizStartPage()
    }
    
    @IBAction private func onBtnHistory(_ sender: Any) {
        navigateToQuizHistoryPage()
    }

}
