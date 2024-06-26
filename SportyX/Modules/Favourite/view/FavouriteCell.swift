//
//  FavouriteCell.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import UIKit

class FavouriteCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var img: UIImageView!
   
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    override func layoutSubviews() {
         super.layoutSubviews()
         
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
