//
//  Created by Emilio Peláez on 19/1/23.
//

import SwiftUI

public extension View {
	func receiveContentMargin() -> some View {
		modifier(ContentMarginModifier())
			.installs(ContentMarginModifier.self, preventDuplicates: true)
	}
	
	func addToBottomMaring() -> some View {
		overlay {
			GeometryReader { proxy in
				Color.clear
					.preference(key: ContentMarginPreferenceKey.self,
											value: EdgeInsets(top: 0, leading: 0, bottom: proxy.size.height, trailing: 0))
			}
		}
		.requires(ContentMarginModifier.self, mode: .relaxed)
	}
}

struct ContentMarginPreferenceKey: PreferenceKey {
	static var defaultValue: EdgeInsets = .init()
	
	static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
		value += nextValue()
	}
}

struct ContentMarginEnvironmentKey: EnvironmentKey {
	static var defaultValue: EdgeInsets = .init()
}

public struct ContentMarginModifier: ViewModifier, HierarchyDependency {
	@State private var margin: EdgeInsets = .init()
	
	public func body(content: Content) -> some View {
		content
			.onPreferenceChange(ContentMarginPreferenceKey.self) { margin = $0 }
			.environment(\.contentMargin, margin)
	}
}

public extension EnvironmentValues {
	var contentMargin: EdgeInsets {
		get { self[ContentMarginEnvironmentKey.self] }
		set { self[ContentMarginEnvironmentKey.self] = newValue }
	}
}
