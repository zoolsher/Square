//
//  CollectionTableViewCell.swift
//  Square
//
//  Created by zoolsher on 2016/8/6.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var postByLabel: UILabel!
    
    @IBOutlet weak var collectionImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var introTextView: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    func loadData(time:String,postedBy:String,title:String,intro:String,category:String,view:String,heart:String,comment:String){
        
        self.timeLabel.text = time;
        self.postByLabel.text = postedBy;
        self.titleLabel.text = title;
        self.introTextView.text = intro;
        self.categoryLabel.text = category;
        self.viewLabel.text = view;
        self.heartLabel.text = heart;
        self.commentLabel.text = comment;
        
        
        
        
    
    }
    
    func loadImage(img:UIImage){
        
        
        self.collectionImageView.image = img
        
        
        collectionImageView.contentMode = .scaleAspectFill
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.timeLabel.text = "";
        self.postByLabel.text = "";
        self.titleLabel.text = "";
        self.introTextView.text = "";
        self.categoryLabel.text = "";
        self.viewLabel.text = "";
        self.heartLabel.text = "";
        self.commentLabel.text = "";
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
