//
//  ContentView.swift
//  Example
//
//  Created by Emilio Peláez on 06/10/23.
//

import AboutKit
import SwiftUI
import UIToolKit

struct ContentView: View {
	@State var showAbout = true
	
	var body: some View {
		Button("Show About") {
			showAbout = true
		}
		.sheet(isPresented: $showAbout) {
			AboutView(details: .init(bundle: .main, icon: Image("Icon"), author: "Test"),
								links: [.init(title: "GitHub", url: URL(string: "https://github.com/emiliopelaez/ToolKit")!)])
				.padding()
		}
		.requires(MyDependency.self)
	}
}

#Preview {
	ContentView()
}

struct MyDependency: HierarchyDependency {
	static var requirement: DependencyRequirement { .relaxed }
}
