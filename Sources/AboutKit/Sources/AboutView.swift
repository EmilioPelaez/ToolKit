//
//  Created by Emilio Peláez on 1/10/23.
//

import SwiftUI
import ToolKit
import UIToolKit

public struct AboutView: View {
	@Environment(\.openURL) var openURL
	private let iconSize: CGFloat = Platform.current == .vision ? 100 : 150
	
	let details: AppDetails
	let links: [AboutLink]
	
	public init(details: AppDetails, links: [AboutLink] = []) {
		self.details = details
		self.links = links
	}
	
	public var body: some View {
		VStack(alignment: .center, spacing: .paddingLarge) {
#if os(visionOS)
			ZStack(alignment: .center) {
				ZStack {
					Circle()
						.fill(.black)
					iconView
						.opacity(0.15)
				}
				.frame(width: iconSize * 0.85, height: iconSize * 0.85)
				.opacity(0.35)
				.blur(radius: 15)
				iconView
					.frame(width: iconSize, height: iconSize)
					.frame(depth: 50)
			}
#else
			ZStack(alignment: .bottom) {
				iconView
					.frame(width: iconSize, height: iconSize / 10)
					.blur(radius: 10)
					.offset(x: 0, y: iconSize / 50)
				iconView
					.frame(width: iconSize, height: iconSize)
			}
#endif
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
			.paddingMedium(.bottom)
			ForEach(links) { link in
				Button {
					openURL(link.url)
				} label: {
					Label(link.title, systemImage: link.symbol)
				}
				.buttonStyle(.capsule(link.color))
			}
		}
	}
	
	var iconView: some View {
		details.icon
			.resizable()
			.if(Platform.current == .vision) {
				$0.clipShape(Circle())
			} else : {
				$0.clipShape(RoundedRectangle(cornerRadius: iconSize / 6, style: .continuous))
			}
	}
}

#Preview {
	AboutView(details: .example)
}
