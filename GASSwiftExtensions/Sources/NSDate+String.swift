//  Created by Виктор Заикин on 21.07.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.

import Foundation
import SwiftDate

public extension String {
    public func date(format: String) -> Date? {
        return self.date(format: .custom(format))?.absoluteDate
    }

    public func toDate() -> Date? {
        if let dt = date(format: DateFormat.iso8601(options: .withInternetDateTime))?.absoluteDate {
            return dt
        }
        else if let dt = date(format: DateFormat.iso8601(options: .withInternetDateTimeExtended))?.absoluteDate {
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
