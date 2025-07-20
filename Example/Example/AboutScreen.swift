//
//  AboutScreen.swift
//  Example
//
//  Created by Emilio Peláez on 20/7/25.
//

import SwiftUI
import AboutKit
import UIToolKit

struct AboutScreen: View {
	@Environment(\.dismiss) var dismissAction
	
	var body: some View {
		NavigationView {
			AboutView(details: .init(bundle: .main, icon: Image("Icon"), author: "Test"),
								links: [.init(title: "GitHub", url: URL(string: "https://github.com/emiliopelaez/ToolKit")!)])
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					ModalDismissButton(dismissAction)
				}
			}
		}
	}
}
