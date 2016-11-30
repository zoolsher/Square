//
//  NotificationViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/6.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: SegmentControlView!
    
    var curShow = 0{
        didSet{
            switchView()
        }
    };
    
    var curShowingView : UIView? = nil;
    
    var viewArr : [UIView?] = [UIView?]()
    
    func switchView(){
        
        if let curView = curShowingView {
            curView.removeFromSuperview()
        }
        
        if self.curShow < self.viewArr.count {
            if let disView = self.viewArr[self.curShow] {
                self.view.addSubview(disView)
                self.view.insertSubview(disView, atIndex: 0)
                curShowingView = disView
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let message = MessageView(frame:self.view.frame)
        self.viewArr.append(message)
        
        self.initSegmentControl()
        
        // Do any additional setup after loading the view.
    }
    
    func initSegmentControl(){
        segmentControl.name1 = "Message"
        segmentControl.name2 = "Comments"
        segmentControl.name3 = "Notification"
        segmentControl.labelAction = {(lastIndex,index) in
            self.curShow = index;
        }
        self.curShow = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
