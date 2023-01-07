//
//  JSON-PrettyPrint.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-07.
//

import Foundation

extension Data {
    
    /// Here's how to use this to pretty print JSON received from an API:
    // if let prettyPrintedJSONString = data.prettyPrintedJSONString { print(prettyPrintedJSONString) }

    
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
