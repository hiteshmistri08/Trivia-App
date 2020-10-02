//
//  QuizQuestionPage.swift
//  Trivia App
//
//  Created by Hitesh on 01/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class QuizQuestionPage: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet private weak var lblQuestionTitle: UILabel!
    @IBOutlet private weak var lblQuestionNote: UILabel!

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var btnNext: UIBarButtonItem!
    
    //Property
    private let context = AppDelegate.shared.persistentContainer.viewContext
    private unowned var quiz:Quiz!
    private var questionIndex:Int!
    private var options:[String] = []
    private var selectedOptions:[String] = []
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        if questionIndex == 1 {
            self.title = "Question 1"
            lblQuestionTitle.text = quiz.question1
            options = quiz.question1Options!.components(separatedBy: ",")
            lblQuestionNote.text = "Note:- Select any one"
        } else if questionIndex == 2 {
            self.title = "Question 2"
            lblQuestionTitle.text = quiz.question2
            options = quiz.question2Options!.components(separatedBy: ",")
            lblQuestionNote.text = "Note:- Select more than 1"
        }
        setupCollectionView()
    }
    private func setupCollectionView() {
        let padding: CGFloat =  40
        let collectionViewSize = self.view.bounds.size.width - padding
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (collectionViewSize / 2) - 10, height: 40)
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setQuizData(_ quiz:Quiz, _ questionIndex:Int) {
        self.quiz = quiz
        self.questionIndex = questionIndex
    }
    private func renderNextButton(_ isEnable:Bool) {
        btnNext.isEnabled = isEnable
    }
    
    private func updateModel() {
        //Set Answer to the question
        if questionIndex == 1 {
            quiz.questionAnswer1 = selectedOptions.joined(separator: ",")
        } else {
            quiz.createdAt = Date()
            quiz.questionAnswer2 = selectedOptions.joined(separator: ",")
            saveQuizModel() // Save model to core data
        }
    }
    private func saveQuizModel() {
        do {
            try context.save()
            print("Save successfully")
        } catch {
            print("ERROR:= ", error.localizedDescription)
        }
    }
    
    //MARK:- Navigation
    private func navigateToQuizSummaryPage(_ quiz:Quiz) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "QuizSummary") as! QuizSummary
        vc.setQuizData(quiz)
       self.navigationController?.pushViewController(vc, animated: true)
    }
    private func navigateToQuizQuestionPage(_ quiz:Quiz, _ questionIndex:Int) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "QuizQuestionPage") as!     QuizQuestionPage
        vc.setQuizData(quiz, questionIndex)
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- IBAction
    @IBAction private func onBtnNext(_ sender: Any) {
        updateModel()
        if questionIndex == 2 {
            //Show Summary
            navigateToQuizSummaryPage(quiz)
            return
        }
        //Set Next question
        navigateToQuizQuestionPage(self.quiz, self.questionIndex + 1)
    }
    
}

//MARK:- UICollectionViewDataSource
extension QuizQuestionPage:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizQuestionCell.reusableIdentifier, for: indexPath) as! QuizQuestionCell
        var option = ""
        if indexPath.row == 0 {
            option = "A) "
        } else if indexPath.row == 1 {
            option = "B) "
        } else if indexPath.row == 2 {
            option = "C) "
        } else {
            option = "D) "
        }
        option += options[indexPath.row]
        cell.configureCell(option)
        cell.setSelected(selectedOptions.contains(options[indexPath.row]))
        return cell
    }
    
    
}

//MARK:- UICollectionViewDelegate
extension QuizQuestionPage:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if questionIndex == 1 {
            selectedOptions = [options[indexPath.row]]
            collectionView.reloadData()
        } else {
            if let index = selectedOptions.firstIndex(where: {$0 == options[indexPath.row]}) {
                selectedOptions.remove(at: index)
            } else {
                selectedOptions.append(options[indexPath.row])
            }
            collectionView.reloadData()
        }
        
        renderNextButton(selectedOptions.count > 0)
    }
}
