//
//  Created by Emilio Peláez on 23/9/23.
//

import Foundation

public extension Collection {
	var notEmptyOrNil: Self? {
		isEmpty ? nil : self
	}
}
