//
//  WorkViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/4.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

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
        self.navigationController?.navigationBar.barStyle = .black;
        loadTableViewCell()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchWorks { (err) in
            
        }
    }
    
    func loadTableViewCell(){
        
        tableView.dataSource = self;
        tableView.rowHeight = 300
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    let reuse = "_worktableviewcell";
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuse) as? workTableViewCell
        if(tableViewCell==nil){
            print("created one");
            tableViewCell = Bundle.main.loadNibNamed("workTableViewCell", owner: nil, options: nil)?.first as! workTableViewCell;
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
    
    func fetchWorks(cb:(Error)->Void){
        var request = URLRequest(url: URL(string:"/works/getRecomWorks",relativeTo:URL(string:BASE.LOC))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data,response,err) in
            if((err) != nil){
                cb(err!)
                return
            }else{
                DispatchQueue.main.sync {
                    do{
                        self.arr.removeAll(keepingCapacity: true);
                        let res = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        if let tempObj = res as? [String:AnyObject]{
                            if let result = tempObj["result"] as? String{
                                if result == "nok" {
                                    let con = UIAlertController(title: "发生了错误", message: "不知道是什么错误", preferredStyle: UIAlertControllerStyle.alert)
                                    con.addAction(UIAlertAction(title: "好吧", style: UIAlertActionStyle.default, handler: nil));
                                    self.present(con, animated: true, completion: nil);
                                }
                            }
                        } else {
                        
                            if let tempArr = res as? [AnyObject]{
                                for index in 0..<tempArr.count{
                                    if let temp = tempArr[index] as? [String:AnyObject] {
                                        if let owner = temp["owner"] as? [String:String]{
                                            self.arr.append([
                                                "title":(temp["title"] as? String)!,
                                                "postBy":(owner["name"])!,
                                                "image":(temp["cover"] as? String)!,
                                                "time":(temp["time"] as? String)!,
                                                "view":(temp["view"] as? String)! ,
                                                "heart":(temp["likes"] as? String)!,
                                                "comment":(temp["commentsAmount"] as? String)!
                                                ])
                                            self.tableView.reloadData()
                                        }
                                    }
                                }
                            }
                        }
                    } catch is Error {
                        
                    }
                }
            }
        }).resume()
        
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
