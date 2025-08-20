//
//  OpenAIFileResponse.swift
//  SwiftMCP
//
//  Created by Oliver Drobnik on 08.03.25.
//

import Foundation

/// One or more files being returned
#if SKETCH_USE_SWIFT_MACROS
@Schema
#endif
public struct OpenAIFileResponse: Codable, Sendable {
    /// The array of file responses
    public let openaiFileResponse: [FileContent]

/**
     Creates a new collection of file responses
     
     - Parameter files: The array of file responses
     */
    public init(files: [FileContent]) {
        self.openaiFileResponse = files
    }
}

#if !SKETCH_USE_SWIFT_MACROS
extension OpenAIFileResponse: SchemaRepresentable {
    public static let schemaMetadata = SchemaMetadata(name: "OpenAIFileResponse", description: "One or more files being returned", parameters: [SchemaPropertyInfo(name: "openaiFileResponse", type: [FileContent].self, description: "The array of file responses", defaultValue: nil as Sendable?, isRequired: true)])
}
#endif
