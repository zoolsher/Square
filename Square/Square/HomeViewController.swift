//
//  ViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/3.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit



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
        self.navigationController?.navigationBar.barStyle = .black;
        self.initTopSlideImages()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToWorks(_:)))
        self.goToWorkLabel.addGestureRecognizer(tapGR)
        
        self.tabbar.delegate = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set the selected into nil
        self.tabbar.selectedItem = nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
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
        
        scrollView.backgroundColor = UIColor.black
        scrollView.isPagingEnabled = true
        
        for index in 0..<arr.count{
            let workView = WorksOnHomeView(frame: CGRect(x:frame.size.width*CGFloat(index),y:0,width:frame.size.width,height:frame.size.height))
            workView.loadData(title: arr[index]["title"]!, postedBy: arr[index]["postedBy"]!)
            fetchImage(url: URL(string:arr[index]["image"]!)!, res: { (img) in
                print("fetched data")
                workView.loadImg(img: img)
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
        
        scrollView.backgroundColor = UIColor.black
        scrollView.isScrollEnabled = true
        
        
        for index in 0..<arr.count{
            let workView = CollectionOnHomeView(frame: CGRect(x:frame.size.width*CGFloat(index),y:0,width:frame.size.width,height:frame.size.height))
            workView.loadData(title: arr[index]["title"]!, postedBy: arr[index]["postedBy"]!)
            workView.viewAllAction = {() in
                self.performSegue(withIdentifier: "GoToCollection", sender: nil)
            }
            fetchImage(url: URL(string:arr[index]["image"]!)!, res: { (img) in
                print("fetched data")
                workView.loadImg(img: img)
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
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.performSegue(withIdentifier: "GoToWork", sender: nil)
    }
    
    
    //MARK:
    
    //MARK: segue
    func goToWorks(_ sender:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "GoToWork", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "GoToWork"){
            _ = segue.destination as! WorkViewController
        }else{
            _ = segue.destination as! CollectionViewController
        }
    }
    //MARK:
    
    
    //MARK: - TopSlider Prepare and Update
    
    
    func initTopSlideImages(){
        // add tap gesture recognizer
        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        let tapGR3 = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapHandler(_:)));
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGR1)
        imageView2.addGestureRecognizer(tapGR2)
        imageView3.addGestureRecognizer(tapGR3)
        fetchImage (url: URL(string: "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg")!){ (img) in
            self.imageView1.image = img;
            self.imageView2.image = img;
            self.imageView3.image = img;
        }
    }
    
    func imageTapHandler(_ sender:UITapGestureRecognizer){
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
    
    func updateImagePos(_ index:Int){
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 15.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {() -> Void in
                        for i in 0...2{
                            self.imageViewArr?[i].frame = self.imageViewFrameArr[index][i]
                        }
            },
                       completion: nil);
    }
    //MARK:
    
    func fetchImage(url:URL,res:(UIImage)->Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: {(data,_,_) in
            
            let image = UIImage.init(data: data!);
            DispatchQueue.main.sync(execute: {
                res(image!);
            })
        }).resume()
    }
    
}

