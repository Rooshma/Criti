//
//  JSON-PrettyPrint.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-07.
//

/// SwiftUI is imported because I'm adding an extension to VerticalAlignment. Nothing else really needs it (might be smart to move it)
import SwiftUI

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

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension String {

    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }

    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}

// Could I just have three separate static variables, rather than declaring new enums every time? Check once this works.
extension VerticalAlignment {
    enum IMDbAllUsersVerticalCenter: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[VerticalAlignment.center]
        }
    }
    static let imdbMidAll = VerticalAlignment(IMDbAllUsersVerticalCenter.self)
    
    enum IMDbMaleUsersVerticalCenter: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[VerticalAlignment.center]
        }
    }
    static let imdbMidMale = VerticalAlignment(IMDbMaleUsersVerticalCenter.self)
    
    enum IMDbFemaleUsersVerticalCenter: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[VerticalAlignment.center]
        }
    }
    static let imdbMidFemale = VerticalAlignment(IMDbFemaleUsersVerticalCenter.self)
}
