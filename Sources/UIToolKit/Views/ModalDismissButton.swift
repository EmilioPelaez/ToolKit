//
//  Created by Emilio Peláez on 09/04/22.
//

import SwiftUI
import ToolKit

public struct ModalDismissButton: View {
	public enum Style {
		case plain
		case circle
	}
	
	@Environment(\.dismiss) var dismissAction
	
	let dismiss: (() -> Void)?
	let style: Style
	
	public init(style: Style = .plain) {
		self.dismiss = nil
		self.style = style
	}
	
	public init(_ dismissAction: DismissAction, style: Style = .plain) {
		self.dismiss = dismissAction.callAsFunction
		self.style = style
	}
	
	public init(style: Style = .plain, _ dismiss: @escaping () -> Void) {
		self.dismiss = dismiss
		self.style = style
	}
	
	public init(_ binding: Binding<Bool>, style: Style = .plain) {
		self.dismiss = { binding.wrappedValue = false }
		self.style = style
	}
	
	public var body: some View {
		Button(action: buttonAction) {
			if Platform.current == .mac {
				Text("Close")
			} else {
				Image(systemName: "xmark")
					.conditional {
						switch (Platform.current, style) {
						case (.vision, _): $0
						case (_, .plain): $0
						case (_, .circle):
							$0.foregroundStyle(.gray)
								.symbolVariant(.circle.fill)
								.symbolRenderingMode(.hierarchical)
						}
					}
			}
		}
		#if os(visionOS)
		.buttonBorderShape(.circle)
		#endif
		.help("Close")
	}
	
	func buttonAction() {
		if let dismiss {
			dismiss()
		} else {
			dismissAction()
		}
	}
}

struct ModalDismissButton_Previews: PreviewProvider {
	static var previews: some View {
		ModalDismissButton {}
	}
}
