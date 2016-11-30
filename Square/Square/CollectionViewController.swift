//
//  CollectionViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/6.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    static var testURL:String = "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg";
    var arr = [
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"100","intro":"this is a intro about nothing this is a intro about nothing this is a intro about nothing this is a intro about nothing this is a intro about nothing this is a intro about nothing this is a intro about nothing this is a intro about nothing","category":"what"],
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"101","intro":"this is a intro about nothing","category":"what"],
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"102","intro":"this is a intro about nothing","category":"what"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection";
        self.navigationController?.navigationBar.barStyle = .Black;
        // Do any additional setup after loading the view.
        loadTableViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTableViewCell(){
        
        tableView.dataSource = self;
        tableView.rowHeight = 250
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    let reuse = "_collectionTableViewCell";
    
    
        
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier(reuse) as? CollectionTableViewCell
        if(tableViewCell==nil){
            print("created one");
            tableViewCell = NSBundle.mainBundle().loadNibNamed("CollectionTableViewCell", owner: nil, options: nil)?.first as? CollectionTableViewCell;
        }
        
        let data = arr[indexPath.row];
        
        tableViewCell?.loadData(data["time"]!,
                                postedBy: data["postedBy"]!,
                                title: data["title"]!,
                                intro: data["intro"]!,
                                category: data["category"]!,
                                view: data["view"]!,
                                heart: data["heart"]!,
                                comment: data["comment"]!
        )
        fetchImage(NSURL(string:data["image"]!)!, res: {(img) in
//            todo: check the bang of the image lazy load
            tableViewCell?.loadImage(img)
        })
        
        return tableViewCell!;
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
