//
//  QuizQuestionCell.swift
//  Trivia App
//
//  Created by Hitesh on 01/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class QuizQuestionCell: UICollectionViewCell {
 
    //IBOutlet
    @IBOutlet private weak var lblQuestionAnswer: UILabel!

    static let reusableIdentifier = "QuizQuestionCell"
    
    //MARK:- Member function
    func configureCell(_ answer:String) {
        lblQuestionAnswer.text = answer
    }
    func setSelected(_ isSelected:Bool) {
        self.contentView.backgroundColor = isSelected ? UIColor.link : UIColor.white
        self.lblQuestionAnswer.textColor = isSelected ? UIColor.white : UIColor.black
    }
}
