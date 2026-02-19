//
//  TrivailAnswerViewCell.swift
//  AppExamen-iOS
//
//  Created by Tardes on 19/2/26.
//

import UIKit

class TrivailAnswerViewCell: UITableViewCell {
    @IBOutlet weak var labelAnswer: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with answer: String) {
        labelAnswer.text = answer
    }

}
