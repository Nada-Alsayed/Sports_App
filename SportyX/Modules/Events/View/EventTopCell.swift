//
//  EventTopCell.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import UIKit

class EventTopCell: UICollectionViewCell {
   
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var teamImg_2: UIImageView!
    @IBOutlet weak var teamName_2: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var teamImg_1: UIImageView!
    
    @IBOutlet weak var teamName_1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
