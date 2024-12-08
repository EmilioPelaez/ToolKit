//
//  Created by Emilio Peláez on 19/12/22.
//

import HierarchyResponder
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public extension View {
	func onShakeController() -> some View {
#if canImport(UIKit) && !os(watchOS)
		modifier(OnShakeController())
#else
		self
#endif
	}
	
	func onShake(_ perform: @escaping () -> Void) -> some View {
#if canImport(UIKit) && !os(watchOS)
		subscribe(to: ShakeEvent.self) { _ in perform() }
#else
		self
#endif
	}
}

#if canImport(UIKit) && !os(watchOS)
struct ShakeEvent: Event {}

struct OnShakeController: ViewModifier {
	@State var publisher: EventPublisher<ShakeEvent>?
	
	func body(content: Content) -> some View {
		content
			.onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
				publisher?(ShakeEvent())
			}
			.publisher(for: ShakeEvent.self, destination: .lastSubscriber) {
				publisher = $0
			}
	}
}

extension UIDevice {
	static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
	override open func motionEnded(_ motion: UIEvent.EventSubtype, with _: UIEvent?) {
		if motion == .motionShake {
			NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
		}
	}
}
#endif
