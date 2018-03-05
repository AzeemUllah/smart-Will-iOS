//
//  loginModel.swift
//  Smart Will
//
//  Created by Aeman Jamali on 3/3/18.
//  Copyright © 2018 4slash. All rights reserved.
//

import Foundation

class loginModel{
    func login(email: String, password: String) -> Int {
        var returnValue = -1;
        
        // prepare json data
        let json: [String: Any] = ["email": email,"password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://128.199.50.69/api/api-login.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                returnValue = -1;
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: String] {
                
                
                
                if responseJSON["Status"] == "Error"{
                    if responseJSON["Error"] == "Invalid Credentials"{
                        returnValue = -2;
                        return
                    }
                }
                else if responseJSON["Ok"] == "Error"{
                    returnValue = Int(responseJSON["Data"]!)!
                    return
                }
               
                
                
               
                
            }
        }
        
        task.resume()
        
        
        return returnValue;
        
        
       
    }
    
    
    
    
    
}


extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}
