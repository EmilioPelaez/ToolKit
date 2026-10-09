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
	let prerenderedIcon: Bool
	let links: [AboutLink]
	
	public init(details: AppDetails, prerenderedIcon: Bool = false, links: [AboutLink] = []) {
		self.details = details
		self.prerenderedIcon = prerenderedIcon
		self.links = links
	}
	
	public var body: some View {
		VStack(alignment: .center, spacing: .paddingLarge) {
			iconView
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
	
	@ViewBuilder
	var iconView: some View {
		if prerenderedIcon {
			icon
				.shadowed(size: iconSize)
		} else {
#if os(visionOS)
			visionIcon
#else
			renderedIcon
#endif
		}
	}
	
	var icon: some View {
		details.icon
			.resizable()
	}
	
	var renderedIcon: some View {
		icon
			.clipShape(RoundedRectangle(cornerRadius: iconSize / 6, style: .continuous))
			.shadowed(size: iconSize)
	}
	
#if os(visionOS)
	var visionIcon: some View {
		ZStack(alignment: .center) {
			ZStack {
				Circle()
					.fill(.black)
				icon
					.clipShape(Circle())
					.opacity(0.15)
			}
			.frame(width: iconSize * 0.85, height: iconSize * 0.85)
			.opacity(0.35)
			.blur(radius: 15)
			icon
				.clipShape(Circle())
				.frame(width: iconSize, height: iconSize)
				.frame(depth: 50)
		}
	}
#endif
	
	
}

extension View {
	func shadowed(size: CGFloat) -> some View {
		ZStack(alignment: .bottom) {
			self
				.frame(width: size, height: size / 10)
				.blur(radius: 10)
				.offset(x: 0, y: size / 50)
			self
				.frame(width: size, height: size)
		}
	}
}

#Preview {
	AboutView(details: .example)
}
