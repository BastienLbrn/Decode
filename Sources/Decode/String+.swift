//
//  File.swift
//  
//
//  Created by Bastien Lebrun on 16/11/2022.
//

import Foundation

public extension String {
    
    enum CompletionPosition {
        case start
        case end
    }
    
    // MARK: - Public variables
    
    var fromUTF16: String? {
        guard let result = Data(fromHexEncodedString: self) else { return nil }
        return String(data: result, encoding: .utf16)
    }
    
    // MARK: - Public functions
    
    func toHexEncodedString(uppercase: Bool = true, prefix: String = "", separator: String = "") -> String {
        unicodeScalars
            .compactMap { prefix + .init($0.value, radix: 16, uppercase: uppercase) }
            .compactMap { $0.complete(with: "0", desiredSize: 4, position: .start) }
            .joined(separator: separator)
    }
    
    func complete(with char: Character, desiredSize size: Int, position: CompletionPosition) -> String {
        position == .start
        ? completeStartOfString(with: char, desiredSize: size)
        : completeEndOfString(with: char, desiredSize: size)
    }
    
    // MARK: - Private functions
    
    private func completeStartOfString(with char: Character, desiredSize size: Int) -> String {
        var copy = self
        while copy.count < size { copy = "\(char)\(copy)" }
        return copy
    }

    private func completeEndOfString(with char: Character, desiredSize size: Int) -> String {
        var copy = self
        while copy.count < size { copy = "\(copy)\(char)" }
        return copy
    }

}
