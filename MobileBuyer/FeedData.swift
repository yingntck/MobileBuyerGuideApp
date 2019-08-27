//
//  FeedData.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 27/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import Alamofire
import Foundation

class FeedData{
    func feed(url: String, completion: @escaping ([MobileElement]) -> Void) {
        AF.request(URL(string: url)!, method: .get).responseJSON { response in
            print(response)
            switch response.result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([MobileElement].self, from: response.data!)
                    completion(result)
                    print("success")
                } catch {
                    print("catch")
                }
                break
            case let .failure(error):
                print(error)
                break
            }
        }
    }
}

