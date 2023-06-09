//
//  Dictionary+Extension.swift
//  Calendar
//
//  Created by wangxu on 2023/4/9.
//

import UIKit

extension Dictionary{
    func toJsonString() -> String?{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else{return nil}
        guard let str = String.init(data: data, encoding: .utf8) else {return nil}
        return str
    }
}
extension String{

    func toDictionary() -> [String: Any]{
        var dic = [String: Any]()
        
        guard let data = self.data(using: .utf8) else {return dic}
        if let result = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
            dic = result
        }
        return dic
    }
}

