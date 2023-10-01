//
//  Created by Emilio Peláez on 1/10/23.
//

import SwiftUI
import ToolKit
import UIToolKit

public struct AboutView: View {
	@Environment(\.openURL) var openURL
	private let iconSize: CGFloat = 150
	
	let details: AppDetails
	
	public init(details: AppDetails) {
		self.details = details
	}
	
	public var body: some View {
		VStack(alignment: .center, spacing: .paddingLarge) {
			ZStack(alignment: .bottom) {
				iconView
					.frame(width: iconSize, height: iconSize / 10)
					.blur(radius: 10)
					.offset(x: 0, y: iconSize / 50)
				iconView
					.frame(width: iconSize, height: iconSize)
			}
			VStack(alignment: .center, spacing: 0) {
				Text(details.name)
					.font(.largeTitle)
				Text("Version \(details.version.description)")
					.font(.caption)
					.foregroundStyle(.secondary)
			}
			VStack(alignment: .center, spacing: .paddingSmall) {
				Text("Created by")
					.font(.body)
					.foregroundStyle(.secondary)
				Text(details.author)
					.font(.title)
			}
			if let url = details.moreAppsURL {
				Button {
					openURL(url)
				} label: {
					Label("More Apps", systemImage: "square.on.square.badge.person.crop")
				}
				.buttonStyle(.capsule(.accentColor))
			}
		}
	}
	
	var iconView: some View {
		details.icon
			.resizable()
			.clipShape(RoundedRectangle(cornerRadius: iconSize / 6, style: .continuous))
	}
}

#Preview {
	AboutView(details: .example)
}
