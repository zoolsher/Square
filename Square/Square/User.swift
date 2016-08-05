//
//  User.swift
//  Square
//
//  Created by zoolsher on 2016/8/5.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import Foundation


class User{
    
    var userName:String? = nil;
    
    var password:String? = nil;
    
    var loginURL = URL(string: "/user/checkLogin", relativeTo: URL(string:BASE.LOC))!
    
    static var _shared:User? = nil;
    
    static var shared:User = User();
    
    private init(){
        
    }
    
    
    func login(cb:(Error?,String,String)->Void){
        URLSession.shared.reset {
            var request = URLRequest(url: self.loginURL);
            request.httpMethod = "POST";
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            var dic = [String:String]();
            dic.updateValue(self.userName!, forKey: "username")
            dic.updateValue(self.password!, forKey: "password")
            do {
                let d = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted);
                
                request.httpBody = d
                URLSession.shared.dataTask(with: request, completionHandler: {(data,respone,error)in
                    if((error) != nil){
                        cb(error,"","")
                        return
                    }
                    do{
                        let res = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments);
                        
                        if let result = res?["result"] as? String {
                            if(result == "ok"){
                                cb(nil,result,"")
                            }
                            if let reason = res?["reason"] as? String {
                                cb(nil,result,reason)
                            }
                        }
                    }catch is Error{
                        
                    }
                    
                }).resume()
            } catch is Error {
                
            }

        }
    }
    
    func register(){
    
    }
    
    
    
}
