//
//  MessageView.swift
//  Square
//
//  Created by zoolsher on 2016/8/6.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class MessageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var tableView:UITableView? = nil;
    
    
    func setupSubviews(){
        tableView = UITableView()
        //tableView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        self.addSubview(tableView!)
        tableView?.frame = self.bounds
        let tableHeaderView = UIView(frame: CGRect(x:0,y:0,width:100,height:30))
        tableHeaderView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0)
        tableView?.tableHeaderView = tableHeaderView
        tableView?.backgroundColor = UIColor.black
        tableView?.rowHeight = 100
        
    }
    
    override func layoutSubviews() {
        tableView?.frame = self.bounds
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
        setupSubviews()
    }
    
    convenience init(){
        self.init(frame:CGRect.zero)
    }

}
