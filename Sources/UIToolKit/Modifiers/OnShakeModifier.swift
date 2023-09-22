//
//  Created by Emilio Peláez on 19/12/22.
//

import SwiftUI
import UIKit

public extension View {
	func onShake(perform action: @escaping () -> Void) -> some View {
		modifier(DeviceShakeViewModifier(action: action))
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

struct DeviceShakeViewModifier: ViewModifier {
	let action: () -> Void
	
	func body(content: Content) -> some View {
		content
			.onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
				action()
			}
	}
}
