//
//  QuizHistoryCell.swift
//  Trivia App
//
//  Created by Hitesh on 01/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class QuizHistoryCell: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak private var lblQuizDetail:UILabel!
    
    //Property
    static let reusableIdentifier = "QuizHistoryCell"
    lazy var dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "dd MMMM hh:mm a"
        return formater
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ quiz:Quiz, _ index:Int) {
        //Set created date in formate
        var createdDate = ""
        if let date = quiz.createdAt  {
            createdDate = dateFormater.string(from: date)
        }
        //Set detail text
        let detail = "GAME \(index) : \(createdDate)\n\nName : \(quiz.name ?? "")\n\n\(quiz.question1 ?? "")\n\nAnswer : \(quiz.questionAnswer1 ?? "")\n\n\(quiz.question2 ?? "")\n\nAnswers : \(quiz.questionAnswer2 ?? "")"
        
        lblQuizDetail.text = detail
    }

}
