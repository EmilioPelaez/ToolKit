//
//  Created by Emilio Peláez on 19/02/22.
//

import CGMath
import SwiftUI

public extension View {
	func getPosition(with coordinateSpace: CoordinateSpace = .global, callback: @escaping (CGPoint) -> Void) -> some View {
		overlay {
			GeometryReader { proxy in
				Color.clear
					.preference(key: PositionPreferenceKey.self, value: proxy.frame(in: coordinateSpace).center)
			}
		}
		.onPreferenceChange(PositionPreferenceKey.self, perform: callback)
	}
	
	func storePosition(in binding: Binding<CGPoint>, with coordinateSpace: CoordinateSpace = .global) -> some View {
		getPosition(with: coordinateSpace) {
			binding.wrappedValue = $0
		}
	}
}

struct PositionPreferenceKey: PreferenceKey {
	static var defaultValue: CGPoint = .zero
	
	static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
		value = nextValue()
	}
}
