//
//  String+Extension.swift
//  NumberFormatter
//
//  Created by kingkong999yhirose on 2015/12/13.
//  Copyright © 2015年 kingkong999yhirose. All rights reserved.
//

import Foundation


extension String {
    func removeString(string: String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
}