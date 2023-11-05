//
//  ExampleApp.swift
//  Example
//
//  Created by Emilio Peláez on 06/10/23.
//

import SwiftUI
import UIToolKit
import CompatibilityKit

@main
struct ExampleApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.installs(MyDependency.self)
				.widgetBackground()
		}
	}
}
