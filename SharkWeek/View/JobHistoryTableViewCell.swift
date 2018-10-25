//
//  JobHistoryTableViewCell.swift
//  SharkWeek
//
//  Created by Cody on 10/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class JobHistoryTableViewCell: UITableViewCell {
    
    var job: Job?{
        didSet{
            let stars = job?.reviewOfEmployer?.rating
            switch stars{
            case 1:
                StarsLabel.text = Stars.one
            case 2:
                StarsLabel.text = Stars.two
            case 3:
                StarsLabel.text = Stars.three
            case 4:
                StarsLabel.text = Stars.four
            case 5:
                StarsLabel.text = Stars.five
            default:
                StarsLabel.text = "Rating Not Found"
            }
            JobTitleLabel.text = job?.title ?? "Title Not found"
            ReviewBodyLabel.text = job?.reviewOfEmployer?.description ?? "Description not found"
        }
    }
    
    @IBOutlet weak var JobTitleLabel: UILabel!
    @IBOutlet weak var StarsLabel: UILabel!
    @IBOutlet weak var ReviewBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
struct Stars{
    static let zero = "☆☆☆☆☆"
    static let one = "★☆☆☆☆"
    static let two = "★★☆☆☆"
    static let three = "★★★☆☆"
    static let four = "★★★★☆"
    static let five = "★★★★★"
    
}
