//
//  LoginViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/3.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!;
    
    @IBOutlet weak var ContainerView: UIView!
    
    var curShow:Int = 0{
        
        didSet{
            self.updateContainerView()
        }
    };
    
    private var defaultView:UIView? = nil;
    private var loginView:UIView? = nil;
    private var registerView:UIView? = nil;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadContainerView();
    }
    
    func loadContainerView(){
        self.defaultView = self.initDefault();
        self.loginView = self.initLogin();
        self.registerView = self.initDefault();
        
        self.ContainerView.addSubview(self.defaultView!);
        self.ContainerView.addSubview(self.loginView!);
        self.ContainerView.addSubview(self.registerView!);
        
        let rect = self.view.frame;
        self.defaultView!.frame = rect.offsetBy(dx: 0*self.view.frame.width, dy: 0);
        self.loginView!.frame = rect.offsetBy(dx: 1*self.view.frame.width, dy: 0);
        self.registerView!.frame = rect.offsetBy(dx: 2*self.view.frame.width, dy: 0);
        
        let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width*3, height: rect.height);
        self.ContainerView.frame = newRect;
        
    }
    
    func updateContainerView(_ animated:Bool = true){
        //spring animation for switch
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 15.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {() -> Void in
                        var rect = self.ContainerView.frame;
                        rect.origin.x = CGFloat(0 - self.curShow) * self.view.frame.width;
                        self.ContainerView.frame = rect;
                        //self.ContainerView.frame.offsetBy(dx: CGFloat(0 - self.curShow) * self.view.frame.width,dy: 0);
            },
                       completion: nil);
    }
    
    
    
    func initDefault()->UIView{
        
        let logo = UIImage(named: "LoginScreenLogo");
        let logoView = UIImageView(image: logo);
        let width = CGFloat(75.0);
        let height = width;
        
        logoView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        logoView.contentMode = .scaleAspectFit;
        
        let containView = UIView(frame: self.view.frame)
        logoView.translatesAutoresizingMaskIntoConstraints = false;
        containView.addSubview(logoView)
        
        let consX = NSLayoutConstraint(item: logoView,
                                       attribute: NSLayoutAttribute.centerX,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: containView,
                                       attribute: NSLayoutAttribute.centerX,
                                       multiplier: 1,
                                       constant: 0);
        let consY = NSLayoutConstraint(item: logoView,
                                       attribute: NSLayoutAttribute.centerY,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: containView,
                                       attribute: NSLayoutAttribute.centerY,
                                       multiplier: 1,
                                       constant: 0);
        let consWidth = NSLayoutConstraint(item: logoView,
                                           attribute: NSLayoutAttribute.width,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: nil,
                                           attribute: NSLayoutAttribute.notAnAttribute,
                                           multiplier: 1,
                                           constant: width);
        let consHeight = NSLayoutConstraint(item: logoView,
                                            attribute: NSLayoutAttribute.height,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: nil,
                                            attribute: NSLayoutAttribute.notAnAttribute,
                                            multiplier: 1,
                                            constant: height);
        //adding app name
        let appName = UILabel()
        appName.font = UIFont(name: "DINCond-Regular", size: 20);
        appName.textColor = UIColor.white;
        appName.text = "Square";
        appName.translatesAutoresizingMaskIntoConstraints = false;
        
        let labelCenterX = NSLayoutConstraint(item: appName,
                                              attribute: NSLayoutAttribute.centerX,
                                              relatedBy: NSLayoutRelation.equal,
                                              toItem: containView,
                                              attribute: NSLayoutAttribute.centerX,
                                              multiplier: 1,
                                              constant: 0);
        let labelTopY = NSLayoutConstraint(item: appName,
                                           attribute: NSLayoutAttribute.top,
                                           relatedBy: NSLayoutRelation.equal,
                                           toItem: logoView,
                                           attribute: NSLayoutAttribute.bottom,
                                           multiplier: 1,
                                           constant: 20);
        
        
        containView.addSubview(appName);
        
        var constrains = [consY,consX,consWidth,consHeight,labelCenterX,labelTopY];
        //adding Slogon
        //        let slogon = UILabel()
        //        slogon.font = UIFont(name: "DINCond-Regular", size: 20);
        //        slogon.textColor = UIColor.white;
        //        slogon.text = "Square";
        //        slogon.translatesAutoresizingMaskIntoConstraints = false;
        let slogon = UIButton()
        //        slogon.titleLabel?.text = "login";
        slogon.titleLabel?.textColor = UIColor.white
        slogon.setTitle("Login", for: UIControlState.normal)
        slogon.addTarget(self, action: #selector(LoginViewController.goToLogin(_:)), for: UIControlEvents.touchUpInside)
        slogon.translatesAutoresizingMaskIntoConstraints = false;
        let slogonCenterX = NSLayoutConstraint(item: slogon,
                                               attribute: NSLayoutAttribute.centerX,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: containView,
                                               attribute: NSLayoutAttribute.centerX,
                                               multiplier: 1,
                                               constant: 0);
        let slogonTopY = NSLayoutConstraint(item: slogon,
                                            attribute: NSLayoutAttribute.top,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: appName,
                                            attribute: NSLayoutAttribute.bottom,
                                            multiplier: 1,
                                            constant: 20);
        constrains.append(slogonTopY);
        constrains.append(slogonCenterX);
        
        containView.addSubview(slogon);
        
        containView.addConstraints(constrains);
        return containView;
    }
    
    func goToLogin(_ sender:UIControlEvents){
        self.curShow = 1;
    }
    
    
    func initLogin()->UIView{
        
        
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blur.frame = self.view.frame;
        let containView = UIView(frame: self.view.frame)
        
        containView.addSubview(blur);
        let loginView = LoginView.init(frame:self.view.frame);
        loginView.backAction = {
            self.curShow = 0
        }
        loginView.goForwardAction = {
            
            let u = User.shared;
            (u.userName,u.password) = loginView.getUserNameAndPassword()
            u.login{(error,res,reason) in
                DispatchQueue.main.async {
                    if((error) != nil){
                        print(error)
                        let alert = UIAlertController(title: "网络错误", message: "网络错误", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "好吧", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        print(res,reason)
                        if(res=="nok"){
                            let alert = UIAlertController(title: "登录失败", message: reason, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "知道了", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }else{
                            UIView.beginAnimations("View Filp", context: nil)
                            UIView.setAnimationDuration(0.4)
                            UIView.setAnimationCurve(.easeInOut)
                            UIView.setAnimationTransition(.flipFromRight, for: self.view, cache: true)
                            
                            let home = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                            self.present(home!, animated: true, completion: nil)
                            //            self.view.addSubview((home?.view)!)
                            //            home?.view.frame = self.view.frame;
                            //            self.ContainerView.removeFromSuperview()
                            
                            UIView.commitAnimations();
                        }
                    }
                }
            };
            
            
        }
        containView.addSubview(loginView);
        return containView;
    }
    
    
    //
    //    func initRegister()->UIView{
    //
    //    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
