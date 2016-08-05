//
//  CollectionViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/6.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    static var testURL:String = "http://att.bbs.duowan.com/forum/201403/24/1543112eltwpai1452ve40.jpg";
    var arr = [
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"100"],
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"101"],
        ["title":"a","postedBy":"posted by Some","image":testURL,"time":"justnow","view":"100","heart":"100","comment":"102"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection";
        self.navigationController?.navigationBar.barStyle = .black;
        // Do any additional setup after loading the view.
        loadTableViewCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
