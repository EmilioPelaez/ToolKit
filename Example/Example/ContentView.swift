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
	@State var showAbout = false
	
	var body: some View {
		buttons
			.sheet(isPresented: $showAbout) {
				AboutScreen()
				.onShake {
					print("Should trigger")
				}
			}
			.onShake {
				print("Should not trigger")
			}
			.requires(MyDependency.self)
	}
	
	var buttons: some View {
		VStack {
			Button("Show About") {
				showAbout = true
			}
			.buttonStyle(.capsule(.red))
			Button("Show About") {
				showAbout = true
			}
			.buttonStyle(.action(.green))
			Button("Show About") {
				showAbout = true
			}
			.buttonStyle(.big(.blue))
			Button("Show About") {
				showAbout = true
			}
			.buttonStyle(.overlay(.yellow))
		}
	}
}

#Preview {
	ContentView()
}

struct MyDependency: HierarchyDependency {
	static var requirement: DependencyRequirement { .relaxed }
}
