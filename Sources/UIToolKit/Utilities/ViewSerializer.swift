//
//  ViewSerializer.swift
//  ToolKit
//
//  Created by Emilio Peláez on 1/24/25.
//

import CoreImage
import SwiftUI

@available(iOS 16.0, macOS 13.0, *)
@MainActor
public struct ViewSerializer<V: View> {
	
	public struct SerializationError: Error {
		let message: String
	}
	
	public let view: V
	public let scale: CGFloat
	
	public init(view: V, scale: CGFloat = 2) {
		self.view = view
		self.scale = scale
	}
	
	public func serialize() throws -> Data {
		let renderer = ImageRenderer(content: view)
		renderer.scale = scale
		renderer.isOpaque = false
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
		guard let image = renderer.nsImage else {
			throw SerializationError(message: "Unable to render image")
		}
		guard let data = data(from: image) else {
			throw SerializationError(message: "Unable to get image data")
		}
		return data
#elseif canImport(UIKit)
		guard let image = renderer.uiImage else {
			throw SerializationError(message: "Unable to render image")
		}
		guard let data = image.pngData() else {
			throw SerializationError(message: "Unable to get image data")
		}
		return data
#endif
	}
	
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
	func data(from image: NSImage) -> Data? {
		guard let tiff = image.tiffRepresentation else { return nil }
		guard let bitmap = NSBitmapImageRep(data: tiff) else { return nil }
		guard let png = bitmap.representation(using: .png, properties: [:]) else { return nil }
		return png
	}
#endif
}

