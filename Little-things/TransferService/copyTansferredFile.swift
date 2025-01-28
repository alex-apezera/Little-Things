//
//  copyTansferredFile.swift
//  Little-things
//
//  Created by Алексей Езерский on 10.04.2025.
//

import SwiftUI

public func copyTransferredFile(_ received: ReceivedTransferredFile) -> URL {
    @AppStorage("copyFile") var copyFile: URL = URL(fileURLWithPath: "")

    let pathExtension = received.file.pathExtension
    let copy = copyFile.appendingPathExtension(pathExtension)
    if FileManager.default.fileExists(atPath: copy.path()) {
        do { try FileManager.default.removeItem(at: copy) }
        catch { print(error.localizedDescription) }
    }
    print("\n", #function, "received:", received, "\n", "copy:", copy)
    
    do { try FileManager.default.copyItem(at: received.file, to: copy) }
    catch { print(error.localizedDescription) }
    return copy
}
