//
//  ViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/3.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire



class HomeViewController: UIViewController,UITabBarDelegate {
    
    //MARK:args
    
    
    @IBOutlet weak var segment: SegmentControlView!
    
    @IBOutlet weak var tabbar: UITabBar!
    
    @IBOutlet weak var HomeTabBarItem: UITabBarItem!
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var goToWorkLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    var isFirstTime : Bool = true;
    
    var scrollViews:[UIScrollView]=[UIScrollView]()
    private var imageViewArr:[UIImageView]? = nil;
    private var imageViewFrameArr:[[CGRect]] = [[CGRect]]();
    
    var headShowArr:[String]?;
    
    //MARK:
    
    //MARK: LifeCyCle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home";
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black;
        self.initTopSlideImages()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToWorks(_:)))
        self.goToWorkLabel.addGestureRecognizer(tapGR)
        
        self.tabbar.delegate = self;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //set the selected into nil
        self.tabbar.selectedItem = nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        if(isFirstTime){
            
            self.initImagePos()
            
            self.scrollViews.append(self.initContainerViewCollection())
            
            self.scrollViews.append(self.initContainerViewWorks())
            
            self.scrollViews.append(self.initContainerViewCollection())
            
            self.view.addSubview(self.scrollViews.first!)
            
            self.initSegment()
            
            isFirstTime = false;
        }
    }
    //MARK:
    
    func initSegment(){
        self.segment.labelAction={(lastIndex,index)->Void in
            print(lastIndex,index)
            self.scrollViews[lastIndex].removeFromSuperview()
            self.view.addSubview( self.scrollViews[index] )
        }
    }
    
    static var testURL:String = "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg";
    var arr = [
        ["title":"a","postedBy":"posted by Some","image":testURL],
        ["title":"a","postedBy":"posted by Some","image":testURL],
        ["title":"a","postedBy":"posted by Some","image":testURL]
    ]
    
    /**
     * this is works
     */
    func initContainerViewWorks()->UIScrollView{
        let frame = self.containerView.frame;
        let scrollView = UIScrollView(frame:frame)
        
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.pagingEnabled = true
        
        for index in 0..<arr.count{
            let workView = WorksOnHomeView(frame: CGRect(x:frame.size.width*CGFloat(index),y:0,width:frame.size.width,height:frame.size.height))
            workView.loadData(arr[index]["title"]!, postedBy: arr[index]["postedBy"]!)
            fetchImage(NSURL(string:arr[index]["image"]!)!, res: { (img) in
                print("fetched data")
                workView.loadImg(img)
            })
            scrollView.addSubview(workView)
        }
        
        scrollView.contentSize = CGSize(width: frame.size.width*CGFloat(arr.count), height: frame.size.height)
        
        return scrollView
        
    }
    
    func initContainerViewCollection()->UIScrollView{
        let frame = CGRect(x:self.containerView.frame.origin.x,
                           y:self.containerView.frame.origin.y,
                           width:self.containerView.frame.height,
                           height:self.containerView.frame.height);
        let scrollView = UIScrollView(frame:self.containerView.frame)
        
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.scrollEnabled = true
        
        
        for index in 0..<arr.count{
            let workView = CollectionOnHomeView(frame: CGRect(x:frame.size.width*CGFloat(index),y:0,width:frame.size.width,height:frame.size.height))
            workView.loadData(arr[index]["title"]!, postedBy: arr[index]["postedBy"]!)
            workView.viewAllAction = {() in
                self.performSegueWithIdentifier("GoToCollection", sender: nil)
//                self.performSegue(withIdentifier: "GoToCollection", sender: nil)
            }
            fetchImage(NSURL(string:arr[index]["image"]!)!, res: { (img) in
                print("fetched data")
                workView.loadImg(img)
            })
            scrollView.addSubview(workView)
        }
        
        scrollView.contentSize = CGSize(width: frame.size.width*CGFloat(arr.count), height: frame.size.height)
        
        return scrollView
        
    }
    
    
    
    
    //MARK: HOME
    func prepareHomeTabBarItem(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToWorks(_:)));
        
    }
    
    func tabBar(tabBar: UITabBar, didSelect item: UITabBarItem) {
//        let index = tabBar.items?.index(of: item);
        let index = tabBar.items?.indexOf(item)
        let v:Int = index!;
        switch v{
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
//            self.performSegue(withIdentifier: "GoToNotification", sender: nil)
            self.performSegueWithIdentifier("GoToNotification", sender: nil)
            break;
        case 4:
            break;
        default:
            break;
        }
        
    }
    
    
    //MARK:
    
    //MARK: segue
    func goToWorks(sender:UITapGestureRecognizer){
//        self.performSegue(withIdentifier: "GoToWork", sender: nil)
        self.performSegueWithIdentifier("GoToWork", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier!{
        case "GoToWork":
            _ = segue.destinationViewController as! WorkViewController
            break;
        case "GoToNotification":
            _ = segue.destinationViewController as! NotificationViewController
            break;
        case "GoToCollection":
            _ = segue.destinationViewController as! CollectionViewController
            break;
        default:
            break;
        }

    }
    
    
    //MARK:
    
    
    //MARK: - TopSlider Prepare and Update
    
    
    func initTopSlideImages(){
        // add tap gesture recognizer
        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        let tapGR3 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        imageView1.userInteractionEnabled = true
        imageView2.userInteractionEnabled = true
        imageView3.userInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGR1)
        imageView2.addGestureRecognizer(tapGR2)
        imageView3.addGestureRecognizer(tapGR3)
        fetchImage (NSURL(string: "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg")!){ (img) in
            self.imageView1.image = img;
            self.imageView2.image = img;
            self.imageView3.image = img;
        }
    }
    
    func imageTapHandler(sender:UITapGestureRecognizer){
        // dispatch action
        if(sender.view == imageView1){
            self.updateImagePos(0)
        }else if(sender.view == imageView2){
            self.updateImagePos(1)
        }else{
            self.updateImagePos(2)
        }
    }
    
    func initImagePos(){
        /**
         * init the imageView arr and imageViewFrameArr so it will be faster to use in the animation like `updateImagePos(2)`
         */
        imageViewArr = [UIImageView]();
        imageViewArr?.append(imageView1)
        imageViewArr?.append(imageView2)
        imageViewArr?.append(imageView3)
        var result = CGFloat(0.0);
        for i in imageViewArr!{
            result += i.frame.height
        }
        let nh = result/5;
        let sh = 3*nh;
        let w = imageView1.frame.width;
        let startY = imageView1.frame.origin.y;
        self.imageViewFrameArr = [
            [
                CGRect(x: 0, y: startY + 0, width: w, height: sh),
                CGRect(x: 0, y: startY + sh, width: w, height: nh),
                CGRect(x: 0, y: startY + sh+nh, width: w, height: nh)
            ],
            [
                CGRect(x: 0, y: startY + 0, width: w, height: nh),
                CGRect(x: 0, y: startY + nh, width: w, height: sh),
                CGRect(x: 0, y: startY + sh+nh, width: w, height: nh)
            ],
            [
                CGRect(x: 0, y: startY + 0, width: w, height: nh),
                CGRect(x: 0, y: startY + nh, width: w, height: nh),
                CGRect(x: 0, y: startY + 2*nh, width: w, height: sh)
            ]
        ]
        updateImagePos(1)
        return ;
    }
    
    func updateImagePos(index:Int){
        UIView.animateWithDuration(0.5,
//        (withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 15.0,
                       options: UIViewAnimationOptions.CurveEaseInOut,
                       animations: {() -> Void in
                        for i in 0...2{
                            self.imageViewArr?[i].frame = self.imageViewFrameArr[index][i]
                        }
            },
                       completion: nil);
    }
    //MARK:
    
    func fetchImage(url:NSURL,res:(UIImage)->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            Alamofire.request(.GET, url)
                .responseImage { (response) in
                    debugPrint(response)
                    dispatch_async(dispatch_get_main_queue()){
                        res(response.result.value!)
                    }
            }
        }
    }
    
}

