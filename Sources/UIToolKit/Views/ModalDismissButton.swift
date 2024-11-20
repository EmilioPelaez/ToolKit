//
//  Created by Emilio Peláez on 09/04/22.
//

import SwiftUI
import ToolKit

public struct ModalDismissButton: View {
	@Environment(\.dismiss) var dismissAction
	
	let dismiss: (() -> Void)?
	
	public init() {
		self.dismiss = nil
	}
	
	public init(_ dismissAction: DismissAction) {
		self.dismiss = dismissAction.callAsFunction
	}
	
	public init(_ dismiss: @escaping () -> Void) {
		self.dismiss = dismiss
	}
	
	public init(_ binding: Binding<Bool>) {
		self.dismiss = { binding.wrappedValue = false }
	}
	
	public var body: some View {
		Button(action: buttonAction) {
			Image(systemName: "xmark")
				.if(Platform.current == .vision) {
					$0.foregroundStyle(.white)
						.font(.body)
				} else: {
					$0.foregroundStyle(.gray)
						.symbolVariant(.circle.fill)
						.font(.title)
				}
				.symbolRenderingMode(.hierarchical)
		}
		#if os(visionOS)
		.buttonBorderShape(.circle)
		#endif
		.help("Dismiss")
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
