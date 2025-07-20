//
//  Created by Emilio Peláez on 20/7/25.
//

import SwiftUI

public extension View {
	func conditional<V: View>(@ViewBuilder _ builder: @escaping (Self) -> V) -> some View {
		builder(self)
	}
}
