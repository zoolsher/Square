//
//  WorksOnHomeView.swift
//  Square
//
//  Created by zoolsher on 2016/8/5.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class WorksOnHomeView: UIView {

    @IBOutlet weak var postByLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAllLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var container: UIView!
    
    weak var view:UIView!;
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func loadData(title:String,postedBy:String){
        self.titleLabel.text = title;
        self.postByLabel.text = title;
    }
    
    func loadImg(img:UIImage){
        self.imageView.image = img;
    }
    
    func loadViewFromXib()->UIView{
        let bundle = Bundle.main.loadNibNamed("WorksOnHomeView", owner: self, options: nil);
        let tmpView = bundle?.first as! UIView;
        return tmpView;
    }
    
    func setupSubviews(){
        
        view = loadViewFromXib()
        view.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth];
        self.addSubview(view)
        container.frame = self.bounds
        
    }

    
    override func layoutSubviews() {
        view.frame = self.bounds
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
