//
//  CollectionViewCell.swift
//  SharkWeek
//
//  Created by Cody on 10/18/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit



class homeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var job: Job?{
        didSet{
            self.layer.borderWidth = 0.5
            self.layer.borderColor = #colorLiteral(red: 0.643494308, green: 0.6439372897, blue: 0.6583478451, alpha: 1)
            self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.layer.cornerRadius = 5
            self.layer.shadowRadius = 1
            self.layer.shadowOpacity = 0.7
            self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.layer.masksToBounds = false;
            self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
            loadViews()
        }
    }
    func loadViews(){
        guard let job = job else {return}
        FirestoreClient.shared.fetchFromFirestore(uuid: job.employerRef) { (user: User?) in
            guard let user = user else {return}
            let employerName = user.firstName
            var rating = 0
            if user.reviewCount != 0{
                rating = user.starCount / user.reviewCount
            }
            self.doStuff(name: employerName, userRating: rating)
            
        }
        
        
        
    }
    func doStuff(name: String, userRating: Int){
        guard let job = job else {return}
        
        titleLabel.text = job.title
        payLabel.text = "$\(job.pay)"
        zipCodeLabel.text = job.zipCode
        //I need a read user function for name and employer rating
        nameLabel.text = name
        switch userRating {
        case 1:
            ratingLabel.text = Stars.one
        case 2:
            ratingLabel.text = Stars.two
        case 3:
            ratingLabel.text = Stars.three
        case 4:
            ratingLabel.text = Stars.four
        case 5:
            ratingLabel.text = Stars.five
        default:
            ratingLabel.text = Stars.zero
        }
    }
}

