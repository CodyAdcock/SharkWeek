//
//  SearchTableViewCell.swift
//  SharkWeek
//
//  Created by Sam on 10/28/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobPay: UILabel!
    @IBOutlet weak var jobCity: UILabel!
    @IBOutlet weak var jobZip: UILabel!
    
    var searchedJob: Job? {
        didSet {
            updateViewsCell()
        }
    }
    
    func updateViewsCell() {
        guard let searchedJob = searchedJob else { return }
        jobTitle.text = searchedJob.title
        jobPay.text = String(searchedJob.pay)
        jobCity.text = searchedJob.city
        jobZip.text = searchedJob.zipCode
    }
}
