//
//  Created by Emilio Peláez on 1/10/23.
//

import Foundation

public extension Bundle {
	var displayName: String {
		guard let name = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
						object(forInfoDictionaryKey: "CFBundleName") as? String else {
			assertionFailure("CFBundleDisplayName and CFBundleName not found")
			return "Application"
		}
		return name
	}
}
