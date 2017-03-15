//  Created by Виктор Заикин on 21.07.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import Foundation
import SwiftDate

public extension String {
    public func date(format: String) -> Date? {
        let date = try? self.date(format: .custom(format))
        return date?.absoluteDate
    }
    
    public func toDate() -> Date? {
        if let dt = try? date(format: DateFormat.iso8601(options: .withInternetDateTime)).absoluteDate {
            return dt
        }
        else if let dt = try? date(format: DateFormat.iso8601(options: .withInternetDateTimeExtended)).absoluteDate {
            return dt
        }
        else if let dt = date(format: "yyyy-MM-dd") {
            return dt
        }
        else {
            return nil
        }
    }
}
