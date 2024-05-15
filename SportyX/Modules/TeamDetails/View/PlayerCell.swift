//
//  PlayerCell.swift
//  SportyX
//
//  Created by MAC on 22/05/2023.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override var frame: CGRect{
        get{
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.size.width -= 2 * 8
            frame.origin.y += 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
        
    }

}
