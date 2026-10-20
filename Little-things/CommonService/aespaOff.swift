//
//  aespaOff.swift
//  Little-things
//
//  Created by Алексей Езерский on 21.05.2025.
//

import Aespa

/// Stop media session.
/// 
public func aespaOff()  {
    let aespa = Aespa.self
    do {
        try aespa.terminate {_ in
            print("VIDEO SESSION TERMINATED")
        }
    } catch {
        print("TERMINATE ERROR: \(error)")
    }

}
