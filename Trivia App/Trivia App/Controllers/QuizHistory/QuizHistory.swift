//
//  QuizHistory.swift
//  Trivia App
//
//  Created by Hitesh on 01/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit
import CoreData

final class QuizHistory: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak private var tableView:UITableView!
    
    //Property
    private var quizs:[Quiz] = []
    private let context = AppDelegate.shared.persistentContainer.viewContext

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        self.title = "History"
        setupTableView()
        loadQuizData(with: Quiz.fetchRequest())
    }
    private func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
    }
    //Load data from core data
    private func loadQuizData(with request:NSFetchRequest<Quiz> = Quiz.fetchRequest(), predicate:NSPredicate? = nil) {
        do {
            quizs = try context.fetch(request)
            print("quizs:=",quizs)
        } catch {
            print("fetch request error:= \(error)")
        }
        tableView.reloadData()
    }
}

//MARK:- UITableViewDataSource
extension QuizHistory:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizHistoryCell.reusableIdentifier) as! QuizHistoryCell
        cell.configureCell(quizs[indexPath.row], indexPath.row + 1)
        return cell
    }
}
