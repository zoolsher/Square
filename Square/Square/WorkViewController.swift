//
//  WorkViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/4.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import Alamofire

class WorkViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var testURL:String = "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg";
    var arr = [
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"100"],
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"101"],
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"102"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<100{
            var data = arr[0];
            data["comment"] = String(Int(arr[0]["comment"]!)!+i*5);
            arr.append(data);
        }
        self.title = "Work";
        self.navigationController?.navigationBar.barStyle = .Black;
        loadTableViewCell()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.fetchWorks { (err) in
            
        }
    }
    
    func loadTableViewCell(){
        
        tableView.dataSource = self;
        tableView.rowHeight = 300
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    let reuse = "_worktableviewcell";
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier(reuse) as? workTableViewCell
        if(tableViewCell==nil){
            print("created one");
            
            tableViewCell = NSBundle.mainBundle().loadNibNamed("workTableViewCell", owner: nil, options: nil)?.first as! workTableViewCell;
        }
        
        let data = arr[indexPath.row];
        
        print("load \(data["comment"]!)")
        tableViewCell?.loadData(title: data["title"]!, postedBy: data["postedBy"]!, time: data["time"]!, view: data["view"]!, heart: data["heart"]!, comment: data["comment"]!)
        fetchImage(url: URL(string:data["image"]!)!, res: {(img) in
            //todo: check the bang of the image lazy load
            if(tableViewCell?.comment == data["comment"]!){
                tableViewCell?.loadImage(image: img);
            }
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

    
    func fetchWorks(cb:(NSError)->Void){
        var manager = Manager.sharedInstance
        manager.session.configuration.HTTPAdditionalHeaders=[
            "Content-Type":"application/json"
        ]
        
        Alamofire.request(.GET, BASE.LOC+"/works/getRecomWorks").responseJSON { (response) in
            if let err = response.result.error {
                cb(err)
            }else{
                dispatch_async(dispatch_get_main_queue()){
                    if let JSON = response.result.value{
                        let result = JSON["result"]
                        if result!!.string == "nok"{
                            let con = UIAlertController(title: "发生了错误", message: "不知道是什么错误", preferredStyle: UIAlertControllerStyle.Alert)
                            con.addAction(UIAlertAction(title: "好吧", style: UIAlertActionStyle.Default, handler: { action in
                                self.arr.removeAll()
                                self.tableView.reloadData()
                            }));
                            self.presentViewController(con, animated: true, completion: nil)
                        }else{
                            self.arr.removeAll();
                            for index in 0..<result!!.array.count{
                                let temp = result!!.array[index]
                                let tempResult = [
                                    "title":temp["title"]!.string,
                                    "postBy":temp["owner"]!["name"]!.string,
                                    "image":temp["cover"]!.string,
                                    "time":temp["time"]!.string,
                                    "view":temp["view"]!.string,
                                    "heart":temp["likes"]!.string,
                                    "comment":temp["commentsAmount"]!.string
                                ]
                                self.arr.append(tempResult)
                            }
                            self.tableView.reloadData()
                        }
                    }
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
