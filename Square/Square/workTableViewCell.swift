//
//  workTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/5.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class workTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var postedByLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var workImageView: UIImageView!
    
    var title:String = "";
    var postedBy:String = "";
    var time:String = "";
    var comment:String = "";
    var view:String = "";
    var heart:String = "";
    
    func loadImage(image:UIImage){
        self.workImageView.image = image;
    }
    
    func loadData( title:String, postedBy:String, time:String, view:String, heart:String, comment:String){
        
        self.title = title;
        
        self.postedBy = postedBy;
        
        self.time = time;
        
        self.comment = comment;
        
        self.view = view;
        
        self.heart = heart;
        
        self.titleLabel.text = title;
        
        self.postedByLabel.text = postedBy;
        
        self.timeLabel.text = time;
        
        self.commentLabel.text = comment;
        
        self.viewLabel.text = view;
        
        self.heartLabel.text = heart;
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.text = title;
        
        self.postedByLabel.text = postedBy;
        
        self.timeLabel.text = time;
        
        self.commentLabel.text = comment;
        
        self.viewLabel.text = view;
        
        self.heartLabel.text = heart;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
