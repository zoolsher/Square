//
//  LoginView.swift
//  Square
//
//  Created by zoolsher on 2016/8/4.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class LoginView: UIView {
    @IBOutlet var container: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    weak var view:UIView!;
    
    var backAction : (()->())?;
    var goForwardAction : (()->Void)?;
    
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func forward(_ sender: UIButton) {
        if let act = goForwardAction{
            act()
        }
    }
    @IBAction func back(_ sender: UIButton) {
        if let act = backAction{
            act()
        }
    }
    func getUserNameAndPassword ()->(String?,String?){
        return (self.userNameTextField.text,self.passwordTextField.text);
    }
    
    func loadViewFromXib()->UIView{
        let bundle = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil);
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
