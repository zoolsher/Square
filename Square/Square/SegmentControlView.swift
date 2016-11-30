//
//  SegmentControlView.swift
//  Square
//
//  Created by zoolsher on 2016/8/4.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class SegmentControlView: UIView {
    
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var tapView: UIView!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    
    weak var view:UIView!;
    
    var name1:String = ""{
        didSet{
            self.label1.text = name1
        }
    }
    var name2:String = ""{
        didSet{
            self.label2.text = name2
        }
    }
    var name3:String = ""{
        didSet{
            self.label3.text = name3
        }
    }
    
    private var labelArr = [UILabel]()
    var labelAction : ((Int,Int)->())? = nil
    private var tGR = [UITapGestureRecognizer]()
    private var curIndex = 0;
    func loadAction(){
        labelArr.append(label1)
        labelArr.append(label2)
        labelArr.append(label3)
        
        for i in 0..<labelArr.count {
            let tempGR = UITapGestureRecognizer(target: self, action: #selector(dispatchAction(_:)))
            labelArr[i].addGestureRecognizer(tempGR)
            //labelArr[i].isUserInteractionEnabled = true
            labelArr[i].userInteractionEnabled = true
            tGR.append(tempGR)
        }
        
        
    }
    
    func dispatchAction(_ sender:UITapGestureRecognizer){
        if let index = tGR.indexOf(sender){
        //if let index = tGR.index(of: sender){
            animation(index)
            if let action = self.labelAction{
                action(curIndex,index)
            }
            curIndex = index;
        }
    }
    
    func animation(index : Int){
        if(index == curIndex){
            return
        }else{
            UIView.animateWithDuration(0.5,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 15.0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations: { 
                                        let tempLabel = self.labelArr[self.curIndex];
                                        tempLabel.textColor = UIColor.whiteColor()
                                        let label = self.labelArr[index];
                                        let x = label.frame.origin.x;
                                        let width = label.frame.width;
                                        self.tapView.frame = CGRect(x: x, y: self.tapView.frame.origin.y, width: width, height: self.tapView.frame.height)
                                        label.textColor = UIColor.redColor()
                },
                                       completion: nil)
//            UIView.animate(withDuration: 0.5,
//                           delay: 0.0,
//                           usingSpringWithDamping: 0.5,
//                           initialSpringVelocity: 15.0,
//                           options: UIViewAnimationOptions.curveEaseInOut,
//                           animations: {
//                            let tempLabel = self.labelArr[self.curIndex];
//                            tempLabel.textColor = UIColor.white
//                            let label = self.labelArr[index];
//                            let x = label.frame.origin.x;
//                            let width = label.frame.width;
//                            self.tapView.frame = CGRect(x: x, y: self.tapView.frame.origin.y, width: width, height: self.tapView.frame.height)
//                            label.textColor = UIColor.red
//                },
//                           completion: nil
//            )
        }
    }
    
    
    
    
    func loadViewFromXib()->UIView{
//        let bundle = Bundle.main.loadNibNamed("SegmentControlView", owner: self, options: nil);
        let bundle = NSBundle.mainBundle().loadNibNamed("SegmentControlView", owner: self, options: nil);
        let tmpView = bundle?.first as! UIView;
        return tmpView;
    }
    
    func setupSubviews(){
        
        view = loadViewFromXib()
        view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth];
//            [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth];
        self.addSubview(view)
        container.frame = self.bounds
        
        loadAction()
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
