//
//  Created by Emilio Peláez on 27/2/23.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public struct VerticalLabeledContentStyle: LabeledContentStyle {
	public func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			configuration.label
				.font(.subheadline.smallCaps())
				.foregroundColor(.secondary)
			configuration.content
				.font(.body)
				.foregroundColor(.primary)
		}
	}
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
	static var vertical: VerticalLabeledContentStyle { .init() }
}
