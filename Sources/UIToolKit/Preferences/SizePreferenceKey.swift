//
//  Created by Emilio Peláez on 23/12/22.
//

import SwiftUI

public extension View {
	func getSize(callback: @escaping (CGSize) -> Void) -> some View {
		overlay {
			GeometryReader { proxy in
				Color.clear
					.preference(key: SizePreferenceKey.self, value: proxy.size)
			}
		}
		.onPreferenceChange(SizePreferenceKey.self, perform: callback)
	}
	
	func storeSize(in binding: Binding<CGSize>) -> some View {
		getSize { binding.wrappedValue = $0 }
	}
}

struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}
